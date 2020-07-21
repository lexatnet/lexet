#!/bin/bash

install_sbcl() {
  local local_repo=''
  local args=("$@")
  local cwd=$(pwd)
  local prefix=/usr/local/share/

  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      --local-repo)
        local_repo=$2
        shift # past argument
        shift # past value
        ;;
      --prefix)
        prefix=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  [ -f ./sbcl-source.tar.bz2 ] || wget --continue --output-document=sbcl-source.tar.bz2 https://sourceforge.net/projects/sbcl/files/latest/download
  [ -f $local_repo ] || mkdir $local_repo
  [ -f ./sbcl-source.tar.bz2 ] && tar -xvf sbcl-source.tar.bz2 --directory $local_repo
  local TT=
  cd $local_repo

  cd $(find ./ -type d -name 'sbcl*' | head -n 1 )

  ./make.sh

  INSTALL_ROOT=${prefix} sh install.sh
  cd $cwd
}
