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


lexet_appimage_builder_bash() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  build_dir=$dir/../build
  [ -d $build_dir ] || mkdir $build_dir

  local entrypoint=$through_point/${appimage_builder_entrypoint_script_name}

  docker run \
         --volume $root/build:$through_point/ \
         --volume $root/recipe.yml:$through_point/recipe.yml:ro \
         --volume $root/scripts/AppRun.sh:$through_point/AppRun:ro \
         --volume $root/scripts/lib/incremental_tags_generation.sh:$through_point/incremental_tags_generation.sh:ro \
         --volume $root/src:$through_point/src:ro \
         --volume $root/packages:$through_point/lexet-packages:ro \
         --volume $root/config:$through_point/config:ro \
         --volume $root/scripts/lib:$through_point/scripts:ro \
         --volume $appimage_builder_entrypoint_script_external:$entrypoint:ro \
         -e through_point=$through_point \
         --user $(id -u ${USER}):$(id -g ${USER}) \
         --interactive \
         --tty \
         --rm \
         --entrypoint bash \
         $appimage_builder_image_tag
}

lexet_appimage_builder_bash