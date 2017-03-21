#!/bin/bash

dir="$(cd "$(dirname "$0")" && pwd)"
source $dir/config.sh

docker build -t $image_name .
