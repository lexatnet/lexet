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

install_ide() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  ln -s ${root}/scripts/run-ide.sh ${install_point_ide}
  ln -s ${root}/scripts/run-ide-x.sh ${install_point_idex}
  ln -s ${root}/scripts/run-ide-x-ssh.sh ${install_point_idex_ssh}
}

install_ide
