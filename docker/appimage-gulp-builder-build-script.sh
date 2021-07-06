#!/usr/bin/env bash

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
source $dir/../scripts/index.sh
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
  apt-get-get install -y glib2.0

  apt-get install -y git
  apt-get install -y autoconf
  apt-get install -y automake
  apt-get install -y autopoint
  apt-get install -y libtool

  apt-get install -y gcc
  apt-get install -y make
  apt-get install -y pkg-config
  apt-get install -y python3-docutils
  apt-get install -y libseccomp-dev
  apt-get install -y libjansson-dev
  apt-get install -y libyaml-dev
  apt-get install -y libxml2-dev

  apt-get install -y libssl-dev
  apt-get install -y libreadline-dev

  apt-get install -y build-essential
  apt-get install -y ruby
  apt-get install -y bison
  apt-get install -y gtk-update-icon-cache
  apt-get install -y fuse
  apt-get install -y libfuse-dev

  apt-get install -y sbcl

  nvm_init_script=/init/nvm.sh
  nvm_root=/env/nvm
  npm_global_config=$nvm_root/.npmrc
  app_run_nvm_dir=/env/nvm

  mkdir /init
  install_nvm \
    --nvm-root $nvm_root \
    --init-script $nvm_init_script \
    --init-nvm-root $app_run_nvm_dir

  apt-get install -y \
    python3-pip \
    python3-setuptools \
    patchelf \
    desktop-file-utils \
    libgdk-pixbuf2.0-dev \
    fakeroot \
    strace
  install_appimage-builder

  rm -rf /var/lib/apt/lists/*
}

main(){
  install_utils
}

main
