#!/bin/bash

install_appimage-builder(){
  # local nvm_root=''
  # local init_nvm_root=$nvm_root
  # local init_script='/etc/profile.d/nvm.sh'
  # local args=("$@")
  local cwd=$(pwd)
  #
  # while [[ $# -gt 0 ]]
  # do
  #   key="$1"
  #   case $key in
  #     --nvm-root)
  #       nvm_root=$2
  #       shift # past value
  #       ;;
  #     --init-nvm-root)
  #       init_nvm_root=$2
  #       shift # past value
  #       ;;
  #     --init-script)
  #       init_script=$2
  #       shift # past argument
  #       shift # past value
  #       ;;
  #     *)    # unknown option
  #       shift # past argument
  #       ;;
  #   esac
  # done
  set -- "${args[@]}" # restore positional parameters

  wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
  chmod +x /usr/local/bin/appimagetool

  pip3 install appimage-builder

  cd $cwd
}
