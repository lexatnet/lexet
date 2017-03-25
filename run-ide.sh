#!/bin/bash

dir="$(cd "$(dirname "$(readlink -f  "$0")")" && pwd)"
source $dir/config.sh

docker run -v $1:$mount_point -v $dir/$emacs_config:$through_point/$emacs_config -it $image_name
