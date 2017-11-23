#!/bin/bash

#Global
root=$(cd $(dirname $(readlink -f  $0)) && pwd)
image_name=ubuntu-emacs-ide
user_id=$UID
group_id=$user_id


#Docker Run
mount_point=/volume
emacs_config=.emacs
through_point=/ide
env_config=env-config.sh
ctags_exclude_config=ctags-exclude.list
ide_tmp_dir=ide-tmp
storage=/storage
workdir=$mount_point
label=${image_name}
ide_project_dir_name=.project
ide_project_dir=${mount_point}/${ide_project_dir_name}
ide_home=${ide_project_dir}/home
ide_server_dir=${ide_project_dir}/server

#Docker Build
docker_file=$root/Dockerfile
build_root=/build
build_script=${build_root}/init.sh
entrypoint_script=${build_root}/entrypoint.sh
dist_point=${build_root}
volume=${image_name}-volume

nvm_root=/opt/nvm

#install
install_name=ide
install_dir=/usr/local/bin
install_point=${install_dir}/${install_name}
