#!/bin/bash

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}

run_lexet_x_ssh() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh
  source $dir/init-project.sh

  container_id_file=$lexet_project_external_dir/docker-container-id
  project_sessions_dir=$lexet_project_external_dir/.ssh-sessions
  [ -d $project_sessions_dir ] || mkdir --parent --verbose $project_sessions_dir

  lexet_ssh_session_file=$(mktemp $project_sessions_dir/lexet.ssh.session.XXXXXXXXX)

  if [ ! -e $container_id_file ]; then

     pid_file=$lexet_project_dir/.ssh/run/sshd.pid
     authorized_keys_file=$lexet_project_dir/.ssh/key.pub
     rsa_host_key_file=$lexet_project_dir/.ssh/ssh_host_rsa_key
     dsa_host_key_file=$lexet_project_dir/.ssh/ssh_host_dsa_key
     ecdsa_host_key_file=$lexet_project_dir/.ssh/ssh_host_ecdsa_key

     lexet_sshd_config_external_file=$lexet_project_external_dir/$sshd_config

     echo "lexet_sshd_config_external_file=$lexet_sshd_config_external_file"

     echo "workdir=$workdir"

     generate_sshd_config \
       --port $sshd_port \
       --pid-file $pid_file \
       --authorized-keys-file $authorized_keys_file \
       --rsa-host-key-file $rsa_host_key_file \
       --dsa-host-key-file $dsa_host_key_file \
       --ecdsa-host-key-file $ecdsa_host_key_file \
       --user $USER \
       > $lexet_sshd_config_external_file

     generate_lexet_user_profile > $lexet_home_external_dir/.profile
     generate_lexet_user_profile > $lexet_home_external_dir/.bashrc


     docker run \
            --name $project_name \
            --label "label=${label}" \
            --volume $lexet_external_root/init:$through_point/init \
            --volume $lexet_external_root/env:$through_point/env \
            --volume $dir/lib:$through_point/lib \
            --volume $project_external_dir:$mount_point \
            --volume $lexet_project_external_dir:$lexet_project_dir \
            --volume $root/config/$emacs_config:$through_point/$emacs_config \
            --volume $root/config/$ctags_exclude_config:$through_point/$ctags_exclude_config \
            --volume $dir/$entrypoint_sshd:$through_point/$entrypoint_sshd \
            --volume $lexet_sshd_config_external_file:$through_point/$sshd_config \
            --volume $lexet_tmp_external_dir:$lexet_tmp_dir \
            --volume $root/packages:$lexet_packages_dir \
            --volume $lexet_vendor_packages_external_dir:$lexet_vendor_packages_dir \
            --env-file $env_config \
            -e USER=$USER \
            -e HOME=$lexet_home \
            -e lexet_home=$lexet_home \
            -e lexet_server_dir=$lexet_server_dir \
            -e lexet_tmp_dir=$lexet_tmp_dir \
            -e lexet_packages_dir=$lexet_packages_dir \
            -e lexet_vendor_packages_dir=$lexet_vendor_packages_dir \
            -e mount_point=$mount_point \
            -e through_point=$through_point \
            -e sshd_config=$sshd_config \
            -e emacs_config=$emacs_config \
            -e group_id=$group_id \
            -e user_id=$user_id \
            -e project_name=$project_name \
            -e lexet_tags_dir=$lexet_tags_dir \
            --workdir $workdir \
            --interactive \
            --tty \
            --rm \
            --entrypoint $through_point/$entrypoint_sshd \
            --detach \
            --publish 2222 \
            $image_tag > $container_id_file

     sleep 15
  fi

  ssh_external_port=$(docker port $project_name 2222/tcp | sed -E "s/.*\:([0-9]+)/\1/g")

  run_lexetx_through_ssh() {
    ssh -v -X -p $ssh_external_port -i $lexet_key_external_dir/$lexet_key_name -o "IdentitiesOnly yes" -o "StrictHostKeyChecking no" localhost "cd $workdir; lexet;"
  }

  try --command run_lexetx_through_ssh --try-times 2

  if [ -e $lexet_ssh_session_file ]; then
     rm $lexet_ssh_session_file
  fi

  if [ -z "$(ls -A $project_sessions_dir)" ]; then
    echo 'no active lexet sessions.'
    echo 'stopping docker...'
    docker stop $project_name
    echo 'docker image stopped.'

    echo 'removing docker ssh link from known hosts...'
    ssh-keygen -f "/home/$USER/.ssh/known_hosts" -R [localhost]:$ssh_external_port
    echo 'docker ssh link removed from known hosts.'

    if [ -e $container_id_file ]; then
      rm $container_id_file
    fi
  else
    echo "exists active lexet sessions."
  fi
}

run_lexet_x_ssh "$@"
