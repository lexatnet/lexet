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

config_lexet_environment() {
  local dir=$(get_script_dir)
  source $dir/../scripts/lib/index.sh

  #Global
  root=$(normalize_path "$dir/..")
  appimage_builder_image_tag=lexatnet/appimage-builder
  appimage_gulp_builder_image_tag=lexatnet/appimage-gulp-builder
  user_id=$UID
  group_id=$user_id


  #Docker Run
  through_point=/lexet
  env_config=$root/config/env-config.sh
  lexet_tmp_dir=$through_point/$(trim -s $lexet_tmp_dir_name)/

  lexet_external_root=~/.lexet
  lexet_home_dir_name=home
  entrypoint_init=entrypoint-init-lexet.sh
  entrypoint_run_lexet=entrypoint-run-lexet.sh
  appimage_builder_entrypoint_script_name=appimage-builder-entrypoint.sh
  appimage_gulp_builder_entrypoint_script_name=appimage-gulp-builder-entrypoint.sh


  #Docker Build
  lexet_docker_file=$root/docker/Dockerfile
  appimage_builder_docker_file=$root/docker/AppImageBuilder-Dockerfile
  appimage_gulp_builder_docker_file=$root/docker/AppImageGulpBuilder-Dockerfile
  sshd_port=2222
  build_root=/build
  appimage_builder_build_script=${build_root}/docker/appimage-builder-build-script.sh
  entrypoint_script=${build_root}/docker/entrypoint.sh
  appimage_builder_entrypoint_script=${build_root}/docker/${appimage_builder_entrypoint_script_name}
  appimage_builder_entrypoint_script_external=${root}/docker/${appimage_builder_entrypoint_script_name}
  appimage_gulp_builder_build_script=${build_root}/docker/appimage-gulp-builder-build-script.sh
  appimage_gulp_builder_entrypoint_script=${build_root}/docker/${appimage_gulp_builder_entrypoint_script_name}
  appimage_gulp_builder_entrypoint_script_external=${root}/docker/${appimage_gulp_builder_entrypoint_script_name}
  dist_point=${build_root}



  nvm_root=$through_point/env/nvm
  rbenv_root=$through_point/env/rbenv

}

config_lexet_environment
