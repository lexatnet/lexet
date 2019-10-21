#!/bin/bash

install_node(){
  local nvm_root=''
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --nvm-root)
        nvm_root=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  #install for non-login bash sesions
  #echo "source $init_script" >> /etc/bash.bashrc

  
  
  # source $nvm_root/nvm.sh
  nvm ls-remote
  # source $nvm_root/nvm.sh
  nvm install node
  # source $nvm_root/nvm.sh

  cd $cwd
}
