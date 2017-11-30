#!/bin/bash

dir=$(cd $(dirname $(readlink -f  $0)) && pwd)
source $dir/config.sh
source $dir/init-project.sh

# TODO: run for project only if not already runned

make run-in-background-as-root


