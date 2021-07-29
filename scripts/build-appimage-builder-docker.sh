#!/usr/bin/env bash
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


build_appimage_builder_image() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  docker build \
    --build-arg build_root=$build_root \
    --build-arg build_script=$appimage_builder_build_script \
    --build-arg entrypoint_script=$appimage_builder_entrypoint_script \
    --tag $appimage_builder_image_tag \
    --file $appimage_builder_docker_file \
    $root
}

build_appimage_builder_image
