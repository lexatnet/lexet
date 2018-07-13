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



install_lexet() {
  local dir=$(get_script_dir)
  source $dir/../config/config.sh

  echo 'Creation lexet links...'
  ln -s ${root}/scripts/run-lexet.sh ${install_point_lexet}
  ln -s ${root}/scripts/run-lexet-x.sh ${install_point_lexetx}
  ln -s ${root}/scripts/run-lexet-x-ssh.sh ${install_point_lexetx_ssh}
  echo 'Lexet links created.'
}

install_lexet
