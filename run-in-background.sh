#!/bin/bash
dir=$(cd $(dirname $(readlink -f  $0)) && pwd)
source $dir/config.sh
source $dir/init-project.sh

docker run \
       --label "label=${label}" \
       --volume $project_external_dir:$mount_point \
       --volume $ide_project_external_dir:$ide_project_dir \
       --volume $dir/$emacs_config:$through_point/$emacs_config \
       --volume $dir/$ctags_exclude_config:$through_point/$ctags_exclude_config \
       --volume $dir/$through_script:$through_point/$through_script \
       --volume $dir/$sshd_config:$through_point/$sshd_config \
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
       --workdir $workdir \
       --interactive \
       --tty \
       --rm \
       --user $user_id:$group_id \
       --entrypoint bash \
       -d \
       -p 2222:2222 \
       $image_name \


