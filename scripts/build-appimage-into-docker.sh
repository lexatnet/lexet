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


build_lexet_appimage() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  docker run \
         --volume $root/build:$through_point/ \
         --volume $root/scripts/docker-build-appimage-entrypoint.sh:$through_point/build.sh \
         --volume $root/recipe.yml:$through_point/recipe.yml \
         -e through_point=$through_point \
         --entrypoint $through_point/build.sh \
         ubuntu:xenial
}

build_lexet_appimage
