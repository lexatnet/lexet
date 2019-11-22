#!/bin/bash

install_bower(){
  local cache='~/.npm'
  local global_config=''
  local user_config=''
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
      --npm-global-config)
        global_config=$2
        shift # past argument
        shift # past value
        ;;
      --npm-user-config)
        user_config=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  echo "prefix = ${prefix}"
  npm config set cache $cache

  npm \
    --globalconfig $global_config \
    --userconfig $user_config install \
    --global bower

  npm cache clean

  cd $cwd
}
