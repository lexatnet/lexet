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

config_ide_environment() {
  local dir=$(get_script_dir)
  source $dir/../scripts/lib/index.sh

  #Global
  root=$(normalize_path "$dir/..")
  image_tag=lexatnet/ide
  user_id=$UID
  group_id=$user_id


  #Docker Run
  mount_point=/volume
  emacs_config=.emacs
  through_point=/ide
  env_config=$root/config/env-config.sh
  ctags_exclude_config=ctags-exclude.list
  ide_tmp_dir_name=ide-tmp
  ide_tmp_dir=$through_point/$(trim -s $ide_tmp_dir_name)/
  storage=/storage
  workdir=$mount_point
  label=${image_tag}
  ide_external_root=~/.ide
  ide_home_dir_name=home
  ide_server_dir_name=server
  ide_project_dir_name=.project
  ide_packages_dir_name=ide-packages


  # ssh
  ide_key_name=key
  ide_ssh_host_rsa_key_name=ssh_host_rsa_key
  ide_ssh_host_dsa_key_name=ssh_host_dsa_key
  ide_ssh_host_ecdsa_key_name=ssh_host_ecdsa_key

  sshd_config=sshd_config
  through_script=through-script.sh



  #Docker Build
  docker_file=$root/docker/Dockerfile
  sshd_port=2222
  build_root=/build
  build_script=${build_root}/docker/init.sh
  entrypoint_script=${build_root}/docker/entrypoint.sh
  dist_point=${build_root}
  volume=${image_tag}-volume

  nvm_root=/opt/nvm

  #install
  install_ide_name=ide
  install_idex_name=idex
  install_idex_ssh_name=idexs
  install_dir=/usr/local/bin
  install_point_ide=${install_dir}/${install_ide_name}
  install_point_idex=${install_dir}/${install_idex_name}
  install_point_idex_ssh=${install_dir}/${install_idex_ssh_name}
}

config_ide_environment
