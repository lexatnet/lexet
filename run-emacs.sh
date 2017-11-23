#!/bin/bash

dir=$(cd $(dirname $(readlink -f  $0)) && pwd)
source $dir/config.sh

cd $mount_point

emacs -q --load $through_point/$emacs_config
