#!/bin/bash

source $through_point/scripts/index.sh

install_bower(){
  npm install --global bower
}

install_gulp(){
  npm install --global gulp
}

install_eslint(){
  npm install --global eslint
  npm install --global babel-eslint
  eslint --init
}

install_jshint(){
  npm install --global jshint
}

install_jscs(){
  npm install --global jscs
}

install_prettier(){
  npm install --global prettier
}


install_utils(){
  local root=''
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --root)
        root=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  
  install_node --nvm-root $root/env/nvm --init-script $root/init/nvm.sh
  install_bower
  install_gulp
  install_eslint
  install_jshint
  install_jscs
  install_prettier
  install_ruby --rbenv-root $root/env/rbenv --init-script $root/init/rbenv.sh
  cd $cwd
}

install_utils "$@"
