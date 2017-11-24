#!/bin/bash

dir=$(cd $(dirname $(readlink -f  $0)) && pwd)
source $dir/config.sh

echo $root
echo $docker_file

docker build \
       --build-arg build_root=$build_root \
       --build-arg build_script=$build_script \
       --build-arg entrypoint_script=$entrypoint_script \
       --tag $image_name \
       --file $docker_file \
       $root

