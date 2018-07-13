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

run_lexetx() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh
  source $dir/init-project.sh

  docker run \
         --name $project_name \
         --label "label=${label}" \
         --volume $project_external_dir:$mount_point \
         --volume $lexet_project_external_dir:$lexet_project_dir \
         --volume $dir/lib:$through_point/lib \
         --volume $root/config/$emacs_config:$through_point/$emacs_config \
         --volume $root/config/$ctags_exclude_config:$through_point/$ctags_exclude_config \
         --volume $lexet_external_root/init:$through_point/init \
         --volume $lexet_external_root/env:$through_point/env \
         --volume $dir/$entrypoint_run_lexet:$through_point/$entrypoint_run_lexet \
         --volume $lexet_tmp_external_dir:$lexet_tmp_dir \
         --volume $lexet_packages_external_dir:$lexet_packages_dir \
         --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
         --env-file $env_config \
         -e DISPLAY=$DISPLAY \
         -e QT_X11_NO_MITSHM=1 \
         -e NO_AT_BRIDGE=1 \
         -e USER=$USER \
         -e HOME=$lexet_home \
         -e lexet_home=$lexet_home \
         -e lexet_server_dir=$lexet_server_dir \
         -e lexet_tmp_dir=$lexet_tmp_dir \
         -e lexet_packages_dir=$lexet_packages_dir \
         -e mount_point=$mount_point \
         -e through_point=$through_point \
         -e emacs_config=$emacs_config \
         -e ctags_exclude_config_path=$through_point/$ctags_exclude_config \
         -e project_name=$project_name \
         -e lexet_tags_dir=$lexet_tags_dir \
         --workdir $workdir \
         --rm \
         --entrypoint $through_point/$entrypoint_run_lexet \
         --user $user_id:$group_id \
         $image_tag
}

run_lexetx "$@"
