#!/bin/bash

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

uninstall_lexet() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  echo 'removing lexet links...'
  rm ${install_point_lexet}
  rm ${install_point_lexetx}
  rm ${install_point_lexetx_ssh}
  echo ' lexet links removed.'
  
  echo 'removing lexet data...'
  rm -r ${lexet_external_root}
  echo 'lexet data removed.'
}

uninstall_lexet
