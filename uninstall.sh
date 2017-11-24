#!/bin/bash

dir="$(cd "$(dirname "$(readlink -f  "$0")")" && pwd)"
source $dir/config.sh

rm ${install_point}
