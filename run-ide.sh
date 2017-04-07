#!/bin/bash

dir="$(cd "$(dirname "$(readlink -f  "$0")")" && pwd)"
source $dir/config.sh

docker run \
	-v $1:$mount_point \
	-v $dir/$emacs_config:$through_point/$emacs_config \
	-v $dir/$ctags_exclude_config:$through_point/$ctags_exclude_config \
	--env-file $root/$env_config \
	--interactive \
	--tty \
	$image_name
