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

init_lexet() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  echo "Checking if lexet data directory exists..."
  if [ ! -d "$lexet_external_root" ]; then
    echo 'lexet data directory not found.'
    local lexet_packages_dir=${through_point}/$lexet_packages_dir_name
    local lexet_packages_external_dir=$lexet_external_root/$lexet_packages_dir_name

    local lexet_external_home=$lexet_external_root/home
    local lexet_external_env=$lexet_external_root/env
    local lexet_external_init=$lexet_external_root/init

    echo 'Creation lexet data directories structure...'
    [ -d $lexet_packages_external_dir ] || mkdir --parent --verbose $lexet_packages_external_dir
    [ -d $lexet_external_home ] || mkdir --parent --verbose $lexet_external_home
    [ -d $lexet_external_env ] || mkdir --parent --verbose $lexet_external_env
    [ -d $lexet_external_init ] || mkdir --parent --verbose $lexet_external_init
    echo 'Lexet data directories structure created.'

    echo "runing docker"
    docker run \
           --name 'init-lexet' \
           --label "label=${label}" \
           --volume $root/config/$emacs_config:$through_point/$emacs_config \
           --volume $dir/lib:$through_point/lib \
           --volume $dir/$entrypoint_init:$through_point/$entrypoint_init \
           --volume $lexet_external_init:$through_point/init \
           --volume $lexet_external_env:$through_point/env \
           --volume $lexet_packages_external_dir:$lexet_packages_dir \
           --volume $lexet_external_home:$through_point/home \
           --env-file $env_config \
           -e USER=$USER \
           -e HOME=$through_point/home \
           -e lexet_home=$through_point/home \
           -e lexet_server_dir=$lexet_server_dir \
           -e lexet_tmp_dir=$lexet_tmp_dir \
           -e lexet_packages_dir=$lexet_packages_dir \
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
init_lexet
