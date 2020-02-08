#!/bin/bash

patch_usr()
{
  local dest='usr/'
  local search='#!/usr/bin/'
  local replace='#!/usr/bin/env '
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --dest)
        dest=$2
        shift # past value
        ;;
      --search)
        search=$2
        shift # past value
        ;;
      --replace)
        replace=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  find $dest -type f -executable -exec sed -i -e "s|${search}|${replace}|g" {} \;
}
