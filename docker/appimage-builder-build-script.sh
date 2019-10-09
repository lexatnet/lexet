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

dir=$(get_script_dir)
source $dir/../config/config.sh

install_utils(){
  echo -e '\n------install_utils------\n'
  apt-get update
  apt-get install -y wget
  apt-get install -y desktop-file-utils
  apt-get install -y file
  export DEBIAN_FRONTEND=noninteractive
  #TZ= Asia/Omsk
  #install tzdata package
  apt-get install -y tzdata
  # set your timezone
  ln -fs /usr/share/zoneinfo/Asia/Omsk /etc/localtime
  dpkg-reconfigure --frontend noninteractive tzdata
  apt-get install -y glib2.0
  rm -rf /var/lib/apt/lists/*
}

main(){
  install_utils
}

main
