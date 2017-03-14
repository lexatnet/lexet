#!/bin/bash

source config.sh

echo "$1:$mount_point"

docker run -v $1:$mount_point -v $(pwd)/$emacs_config:$through_point/$emacs_config -it $image_name
