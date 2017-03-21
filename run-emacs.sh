#!/bin/bash

dir="$(cd "$(dirname "$0")" && pwd)"
source $dir/config.sh

cd $mount_point

emacs -q --load "$through_point/$emacs_config"
