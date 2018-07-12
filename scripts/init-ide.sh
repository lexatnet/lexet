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

init_ide() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  echo "Checking if lexet data directory exists..."
  if [ ! -d "$ide_external_root" ]; then
    echo 'lexet data directory not found.'
    local ide_packages_dir=${through_point}/$ide_packages_dir_name
    local ide_packages_external_dir=$ide_external_root/$ide_packages_dir_name

    local ide_external_home=$ide_external_root/home
    local ide_external_env=$ide_external_root/env
    local ide_external_init=$ide_external_root/init

    echo 'Creation lexet data directories structure...'
    [ -d $ide_packages_external_dir ] || mkdir --parent --verbose $ide_packages_external_dir
    [ -d $ide_external_home ] || mkdir --parent --verbose $ide_external_home
    [ -d $ide_external_env ] || mkdir --parent --verbose $ide_external_env
    [ -d $ide_external_init ] || mkdir --parent --verbose $ide_external_init
    echo 'Lexet data directories structure created.'

    echo "runing docker"
    docker run \
           --name 'init-ide' \
           --label "label=${label}" \
           --volume $root/config/$emacs_config:$through_point/$emacs_config \
           --volume $dir/lib:$through_point/lib \
           --volume $dir/$entrypoint_init:$through_point/$entrypoint_init \
           --volume $ide_external_init:$through_point/init \
           --volume $ide_external_env:$through_point/env \
           --volume $ide_packages_external_dir:$ide_packages_dir \
           --env-file $env_config \
           -e USER=$USER \
           -e HOME=$through_point/home \
           -e ide_home=$through_point/home \
           -e ide_server_dir=$ide_server_dir \
           -e ide_tmp_dir=$ide_tmp_dir \
           -e ide_packages_dir=$ide_packages_dir \
           -e mount_point=$mount_point \
           -e through_point=$through_point \
           -e emacs_config=$emacs_config \
           -e group_id=$group_id \
           -e user_id=$user_id \
           -e rbenv_root=$rbenv_root \
           -e nvm_root=$nvm_root \
           --workdir $workdir \
           --interactive \
           --tty \
           --rm \
           --entrypoint $through_point/$entrypoint_init \
           $image_tag
  fi
}
echo "start initialization"
init_ide
