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

config_lexet_environment() {
  local dir=$(get_script_dir)
  source $dir/../scripts/lib/index.sh

  #Global
  root=$(normalize_path "$dir/..")
  lexet_image_tag=lexatnet/lexet
  appimage_builder_image_tag=lexatnet/appimage-builder
  user_id=$UID
  group_id=$user_id


  #Docker Run
  mount_point=/project
  emacs_config=.emacs
  through_point=/lexet
  env_config=$root/config/env-config.sh
  ctags_exclude_config=ctags-exclude.list
  lexet_tmp_dir_name=lexet-tmp
  lexet_tmp_dir=$through_point/$(trim -s $lexet_tmp_dir_name)/

  storage=/storage
  workdir=$mount_point
  label=${image_tag}
  lexet_external_root=~/.lexet
  lexet_home_dir_name=home
  lexet_server_dir_name=server
  lexet_project_dir_name=.project
  lexet_vendor_packages_dir_name=lexet-vendor-packages
  lexet_packages_dir_name=lexet-packages
  lexet_utils_dir_name=lexet-utils
  entrypoint_sshd=entrypoint-run-sshd.sh
  entrypoint_init=entrypoint-init-lexet.sh
  entrypoint_run_lexet=entrypoint-run-lexet.sh

  # ssh
  lexet_key_name=key
  lexet_ssh_host_rsa_key_name=ssh_host_rsa_key
  lexet_ssh_host_dsa_key_name=ssh_host_dsa_key
  lexet_ssh_host_ecdsa_key_name=ssh_host_ecdsa_key

  sshd_config=sshd_config
  through_script=through-script.sh



  #Docker Build
  lexet_docker_file=$root/docker/Dockerfile
  appimage_builder_docker_file=$root/docker/AppImageBuilder-Dockerfile
  sshd_port=2222
  build_root=/build
  build_script=${build_root}/docker/init.sh
  appimage_builder_build_script=${build_root}/docker/appimage-builder-build-script.sh
  entrypoint_script=${build_root}/docker/entrypoint.sh
  appimage_builder_entrypoint_script=${build_root}/docker/appimage-builder-entrypoint.sh
  dist_point=${build_root}
  volume=${image_tag}-volume

  nvm_root=$through_point/env/nvm
  rbenv_root=$through_point/env/rbenv

  #install
  install_lexet_name=lexet
  install_lexetx_name=lexetx
  install_lexetx_ssh_name=lexetxs
  install_dir=/usr/local/bin
  install_point_lexet=${install_dir}/${install_lexet_name}
  install_point_lexetx=${install_dir}/${install_lexetx_name}
  install_point_lexetx_ssh=${install_dir}/${install_lexetx_ssh_name}
}

config_lexet_environment
