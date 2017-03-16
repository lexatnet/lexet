#!/bin/bash

source /tmp/config.sh

cd $mount_point

emacs -q --load "$through_point/$emacs_config"
