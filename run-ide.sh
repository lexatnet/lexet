#!/bin/bash

dir="$(cd "$(dirname "$(readlink -f  "$0")")" && pwd)"
source $dir/config.sh

project_dir=${1:-''}
tmp_files_dir=${2:-'/tmp'}

docker run \
	-v $project_dir:$mount_point \
	-v $dir/$emacs_config:$through_point/$emacs_config \
	-v $dir/$ctags_exclude_config:$through_point/$ctags_exclude_config \
        -v $tmp_files_dir:$through_point/$ide_tmp_dir \
	--env-file $root/$env_config \
	--interactive \
	--tty \
	$image_name
