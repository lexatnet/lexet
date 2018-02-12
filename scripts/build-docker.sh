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


build_ide_image() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  docker build \
         --build-arg build_root=$build_root \
         --build-arg build_script=$build_script \
         --build-arg entrypoint_script=$entrypoint_script \
         --tag $image_name \
         --file $docker_file \
         $root/docker
}

build_ide_image
