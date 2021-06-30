#!/usr/bin/env bash

install_gulp(){
  local cache='~/.npm'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --cache)
        cache=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  npm config set cache $cache

  npm install \
      --global gulp

  npm cache clean

  cd $cwd
}
