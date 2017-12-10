#!/bin/bash

dir=$(cd $(dirname $(readlink -f  $0)) && pwd)
source $dir/config.sh
source $dir/init-project.sh

# TODO: capture port dinamicaly to allow run multiple innstances
# TODO: add automatic user name detection for ssh_config
# TODO: connect to existing project container if already runned
# TODO: do not run more then one container for project
# TODO: add needed environment variables in ssh environment when external user connecting

container_id_file=$ide_project_external_dir/docker-container-id

pid_file=$ide_project_dir/.ssh/run/sshd.pid
authorized_keys_file=$ide_project_dir/.ssh/key.pub
rsa_host_key_file=$ide_project_dir/.ssh/ssh_host_rsa_key
dsa_host_key_file=$ide_project_dir/.ssh/ssh_host_dsa_key
ecdsa_host_key_file=$ide_project_dir/.ssh/ssh_host_ecdsa_key

ide_sshd_config_external_file=$ide_project_external_dir/$sshd_config

echo "ide_sshd_config_external_file=$ide_sshd_config_external_file"

generate_sshd_config \
  --port $sshd_port \
  --pid-file $pid_file \
  --authorized-keys-file $authorized_keys_file \
  --rsa-host-key-file $rsa_host_key_file \
  --dsa-host-key-file $dsa_host_key_file \
  --ecdsa-host-key-file $ecdsa_host_key_file \
  --user $USER \
  > $ide_sshd_config_external_file

generate_ide_user_profile > $ide_home_external_dir/.profile
generate_ide_user_profile > $ide_home_external_dir/.bashrc

docker run \
       --name $project_name \
       --label "label=${label}" \
       --volume $project_external_dir:$mount_point \
       --volume $ide_project_external_dir:$ide_project_dir \
       --volume $dir/$emacs_config:$through_point/$emacs_config \
       --volume $dir/$ctags_exclude_config:$through_point/$ctags_exclude_config \
       --volume $dir/alter.sh:$through_point/alter.sh \
       --volume $ide_sshd_config_external_file:$through_point/$sshd_config \
       --volume $ide_tmp_external_dir:$ide_tmp_dir \
       --volume $ide_packages_external_dir:$ide_packages_dir \
       --env-file $root/$env_config \
       -e USER=$USER \
       -e HOME=$ide_home \
       -e ide_home=$ide_home \
       -e ide_server_dir=$ide_server_dir \
       -e ide_tmp_dir=$ide_tmp_dir \
       -e ide_packages_dir=$ide_packages_dir \
       -e mount_point=$mount_point \
       -e through_point=$through_point \
       -e sshd_config=$sshd_config \
       -e emacs_config=$emacs_config \
       -e group_id=$group_id \
       -e user_id=$user_id \
       --workdir $workdir \
       --interactive \
       --tty \
       --rm \
       --entrypoint $through_point/alter.sh \
       --detach \
       --publish 2222 \
       $image_name > $container_id_file

sleep 15

ssh_external_port=$(docker port $project_name 2222/tcp | sed -E "s/.*\:([0-9]+)/\1/g")

run_idex_through_ssh() {
  ssh -v -X -p $ssh_external_port -i $ide_key_external_dir/$ide_key_name -o "IdentitiesOnly yes" -o "StrictHostKeyChecking no" localhost "cd /volume; ide;"
}

echo $run_idex_through_ssh

try run_idex_through_ssh 5

docker stop $project_name

#docker rm $project_name

#rm $container_id_file
#
