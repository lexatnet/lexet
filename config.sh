#!/bin/bash

#Global
root="$(cd "$(dirname "$(readlink -f  "$0")")" && pwd)"
image_name='ubuntu-emacs-test'

#Docker Run
mount_point='/volume'
emacs_config='.emacs'
through_point='/ide'
env_config='env-config.sh'
ctags_exclude_config='ctags-exclude.list'

#Docker Build
docker_file="$root/Dockerfile"
build_root='/build'
build_script="$build_root/init.sh"
entrypoint_script="ide"
dist_point="$build_root"


nvm_root='/opt/nvm'

