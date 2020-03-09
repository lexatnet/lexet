#!/bin/bash

install_ctags(){
  local local_repo_cache='./ctags'
  local local_repo=''
  local prefix='/usr/local/share'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --local-repo)
        local_repo=$2
        shift # past value
        ;;
      --local-repo-cache)
        local_repo_cache=$2
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

  [ -d $local_repo_cache ] || git clone --depth 1 https://github.com/universal-ctags/ctags.git $local_repo_cache

  cp -r $local_repo_cache $local_repo
  cd $local_repo
  ./autogen.sh
  ./configure --prefix=${prefix}
  make -j8
  make install
  cd ..
  # clear
  rm --recursive $local_repo
  # restore working directory
  cd $cwd
}
