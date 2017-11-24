#!/bin/bash

dir=$(cd $(dirname $(readlink -f  $0)) && pwd)
source $dir/config.sh
source $dir/init-project.sh

docker run \
       --label "label=${label}" \
       --volume $project_dir:$mount_point \
       --volume $dir/$emacs_config:$through_point/$emacs_config \
       --volume $dir/$ctags_exclude_config:$through_point/$ctags_exclude_config \
       --volume $tmp_files_dir:$through_point/$ide_tmp_dir \
       --volume $volume:$storage \
       --env-file $root/$env_config \
       -e HOME=$ide_home \
       -e ide_home=$ide_home \
       -e ide_server_dir=$ide_server_dir \
       -e ide_tmp_dir=$through_point/$ide_tmp_dir \
       -e mount_point=$mount_point \
       -e through_point=$through_point \
       -e emacs_config=$emacs_config \
       -p 5000:5000 \
       --workdir $workdir \
       --interactive \
       --tty \
       --rm \
       --user $user_id:$group_id \
       $image_name
