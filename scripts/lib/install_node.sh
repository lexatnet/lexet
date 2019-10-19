#!/bin/bash

install_node(){
  local nvm_root=''
  local init_script='/etc/profile.d/nvm.sh'
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
      --init-script)
        init_script=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  git clone https://github.com/nvm-sh/nvm.git $nvm_root
  cd $nvm_root
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  echo "export NVM_DIR=${nvm_root}" >>  $init_script
  echo "source ${nvm_root}/nvm.sh" >>  $init_script

  #install for non-login bash sesions
  #echo "source $init_script" >> /etc/bash.bashrc

  source $nvm_root/nvm.sh
  nvm ls-remote
  source $nvm_root/nvm.sh
  nvm install node
  source $init_script
  cd $cwd
}
