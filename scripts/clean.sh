#!/usr/bin/env bash

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}


clean() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  build_dir=$dir/../build
  [ -d $build_dir ] && echo 'deleting build folder' && rm -rf $build_dir
}

clean
