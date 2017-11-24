#!/bin/bash

dir=$(cd $(dirname $(readlink -f  $0)) && pwd)
source $dir/config.sh

docker exec \
       --interactive \
       --tty \
       $image_name \
       bash

