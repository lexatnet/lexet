#!/bin/bash

source config.sh

cd $mount_point

emacs -q --load "$through/$emacs_config"
