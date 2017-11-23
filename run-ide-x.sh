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
       -e ctags_exclude_config_path=$through_point/$ctags_exclude_config \
       -e DISPLAY=$DISPLAY \
       -e HOME=$ide_home \
       -e ide_home=$ide_home \
       -e ide_server_dir=$ide_server_dir \
       -e ide_tmp_dir=$through_point/$ide_tmp_dir \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       --workdir $workdir \
       --rm \
       --user $user_id:$group_id \
       $image_name
