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

  build_dir=$root/build
  [ -d $build_dir ] || mkdir $build_dir

  staff_dir=$root/staff
  [ -d $staff_dir ] || mkdir $staff_dir

  staff_build_dir=$root/staff/build
  [ -d $staff_build_dir ] || mkdir $staff_build_dir

  staff_build_cache_dir=$root/staff/build/.cache
  [ -d $staff_build_cache_dir ] || mkdir $staff_build_cache_dir

  staff_build_workspace_dir=$root/staff/build/workspace
  [ -d $staff_build_workspace_dir ] || mkdir $staff_build_workspace_dir

  staff_builder_dir=$root/staff/builder
  [ -d $staff_builder_dir ] || mkdir $staff_builder_dir

  staff_builder_home_dir=$root/staff/builder/home
  [ -d $staff_builder_home_dir ] || mkdir $staff_builder_home_dir

  staff_builder_nvm_dir=$root/staff/builder/nvm
  [ -d $staff_builder_nvm_dir ] || mkdir $staff_builder_nvm_dir

  staff_builder_nvm_alias_dir=$root/staff/builder/nvm/alias
  [ -d $staff_builder_nvm_alias_dir ] || mkdir $staff_builder_nvm_alias_dir

  staff_builder_nvm_versions_dir=$root/staff/builder/nvm/versions
  [ -d $staff_builder_nvm_versions_dir ] || mkdir $staff_builder_nvm_versions_dir

  staff_builder_nvm_cache_dir=$root/staff/builder/nvm/.cache
  [ -d $staff_builder_nvm_cache_dir ] || mkdir $staff_builder_nvm_cache_dir

  staff_builder_node_modules_dir=$root/staff/builder/node_modules
  [ -d $staff_builder_node_modules_dir ] || mkdir $staff_builder_node_modules_dir

  local entrypoint=$through_point/${appimage_gulp_builder_entrypoint_script_name}

  docker run \
         --volume $root/build:$through_point \
         --volume $root/builder:/builder \
         --volume $root/staff/build:/builder/build \
         --volume $root/staff/builder/home:/home \
         --volume $root/staff/builder/nvm/versions:/env/nvm/versions \
         --volume $root/staff/builder/nvm/alias:/env/nvm/alias \
         --volume $root/staff/builder/nvm/.cache:/env/nvm/.cache \
         --volume $root/staff/builder/node_modules:/builder/node_modules \
         --volume $root/recipe.yml:$through_point/recipe.yml:ro \
         --volume $root/scripts/AppRun.sh:$through_point/AppRun:ro \
         --volume $root/scripts/lib/incremental_tags_generation.sh:$through_point/incremental_tags_generation.sh:ro \
         --volume $root/src:$through_point/src:ro \
         --volume $root/packages:$through_point/lexet-packages:ro \
         --volume $root/config:$through_point/config:ro \
         --volume $root/scripts/lib:$through_point/scripts:ro \
         --volume $appimage_gulp_builder_entrypoint_script_external:$entrypoint:ro \
         -e through_point=$through_point \
         -e LEXET_MOUNT_POINT=$through_point \
         -e HOME=/home \
         --user $(id -u ${USER}):$(id -g ${USER}) \
         --rm \
         --entrypoint $entrypoint \
         $appimage_gulp_builder_image_tag
}

build_lexet_appimage
