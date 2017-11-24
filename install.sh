#!/bin/bash

dir=$(cd $(dirname $(readlink -f  $0)) && pwd)
source $dir/config.sh

ln -s ${root}/run-ide.sh ${install_point}
