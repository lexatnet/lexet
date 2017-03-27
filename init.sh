#!/bin/bash

dir="$(cd "$(dirname "$(readlink -f  "$0")")" && pwd)"
source $dir/config.sh

install_utils(){
  apt-get update

  apt-get install -y software-properties-common
  apt-get install -y mc

  apt-get install -y git 
  apt-get install -y make
  apt-get install -y autoconf
  apt-get install -y pkg-config

  apt-get install -y php-cli 
  apt-get install -y cscope

  apt-get install -y curl
}

install_emacs(){
  apt-add-repository ppa:ubuntu-elisp/ppa
  apt-get update
  apt-get install -y
  apt-get install -y emacs-snapshot
}


install_ctags(){
  #install ctags from sources

  cd $dist_point
  git clone https://github.com/universal-ctags/ctags.git
  cd ctags
  ./autogen.sh
  ./configure
  make
  make install
}

install_hunspell(){

  cd $dist_point
  git clone https://github.com/hunspell/hunspell.git
  cd hunspell

  autoreconf -vfi
  ./configure
  make
  make install    #if neccesary prefix with sudo
  ldconfig        #not needed on windows, on linux sudo may be needed
}

install_php_utils(){
  cd $dist_point
  curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
  php phpcs.phar -h

  curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
  php phpcbf.phar -h
}

install_node(){
  git clone https://github.com/creationix/nvm.git /opt/nvm
  cd /opt/nvm
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  mkdir /usr/local/nvm
  echo 'export NVM_DIR=/usr/local/nvm' >>  /etc/profile.d/nvm.sh
  echo 'source /opt/nvm/nvm.sh' >>  /etc/profile.d/nvm.sh
  echo 'NODE_PATH=$(nvm which default)'>>  /etc/profile.d/nvm.sh
  echo 'NODE_DIR=$(dirname "${NODE_PATH}")'>>  /etc/profile.d/nvm.sh
  echo 'export PATH="$PATH:$NODE_DIR"' >>  /etc/profile.d/nvm.sh
  source /opt/nvm/nvm.sh
  nvm ls-remote
  source /opt/nvm/nvm.sh
  nvm install node
  source /etc/profile.d/nvm.sh
  npm install -g bower
  npm install -g gulp
}

install_emacs_packages(){
  emacs -q --load "$dist_point/$emacs_config" --batch --kill
}

create_ide_shortcut(){
  ln -s "$dist_point/run-emacs.sh" /usr/bin/ide
}

set_locale(){
  echo "LANG=en_US.utf8" /etc/default/locale
  echo "export LANG=en_US.UTF-8" ~/.bashrc
  #export LANG=en_US.UTF-8
}

install_eslint(){
  npm install -g eslint
  eslint --init
}

main(){
  set_locale
  install_utils
  install_emacs
  install_ctags
  install_php_utils
  install_node
  install_eslint
  install_emacs_packages
  create_ide_shortcut
}

main
