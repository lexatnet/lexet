#!/bin/bash

#Global
root=$(cd $(dirname $(readlink -f  $0)) && pwd)
lib_dir=$root/scripts/lib
source $lib_dir/index.sh
image_name=ubuntu-emacs-ide
user_id=$UID
group_id=$user_id


#Docker Run
mount_point=/volume
emacs_config=.emacs
through_point=/ide
env_config=env-config.sh
ctags_exclude_config=ctags-exclude.list
ide_tmp_dir_name=ide-tmp
ide_tmp_dir=$through_point/$(trim -s $ide_tmp_dir_name)/
storage=/storage
workdir=$mount_point
label=${image_name}
ide_external_root=~/.ide
ide_home_dir_name=home
ide_server_dir_name=server
ide_project_dir_name=.project
ide_packages_dir_name=ide-packages
ide_key_name=key
sshd_config=sshd_config
through_script=through-script.sh



#Docker Build
docker_file=$root/Dockerfile
build_root=/build
build_script=${build_root}/init.sh
entrypoint_script=${build_root}/entrypoint.sh
dist_point=${build_root}
volume=${image_name}-volume

nvm_root=/opt/nvm

#install
install_ide_name=ide
install_idex_name=idex
install_dir=/usr/local/bin
install_point_ide=${install_dir}/${install_ide_name}
install_point_idex=${install_dir}/${install_idex_name}
