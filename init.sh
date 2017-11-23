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

  apt-get install -y language-pack-en-base
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

  # clear
  cd $dist_point
  rm --recursive ctags
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

  # clear
  cd $dist_point
  rm --recursive hunspell
}

install_php_utils(){
  cd $dist_point
  curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
  php phpcs.phar -h
  
  curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
  php phpcbf.phar -h

  # clear
  rm phpcs.phar
  rm phpcbf.phar
}

install_node(){
  git clone https://github.com/creationix/nvm.git $nvm_root
  cd $nvm_root
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  echo "export NVM_DIR=${nvm_root}" >>  /etc/profile.d/nvm.sh
  echo "source ${nvm_root}/nvm.sh" >>  /etc/profile.d/nvm.sh
  #echo 'NODE_PATH=$(nvm which default)'>>  /etc/profile.d/nvm.sh
  #echo 'NODE_DIR=$(dirname "${NODE_PATH}")'>>  /etc/profile.d/nvm.sh
  #echo 'export PATH="$PATH:$NODE_DIR"' >>  /etc/profile.d/nvm.sh
  echo 'source /etc/profile.d/nvm.sh' >> ~/.bashrc
  source $nvm_root/nvm.sh
  nvm ls-remote
  source $nvm_root/nvm.sh
  nvm install node
  source /etc/profile.d/nvm.sh
}

install_emacs_packages(){
  emacs -q --load "$dist_point/$emacs_config" --batch --kill
}

create_ide_shortcut(){
  ln -s "$dist_point/run-emacs.sh" /usr/bin/ide
}

install_bower(){
  npm install -g bower
}

install_gulp(){
  npm install -g gulp
}

install_eslint(){
  npm install -g eslint
  npm install -g babel-eslint
  eslint --init
}

install_jshint(){
  npm install -g jshint
}

install_jscs(){
  npm install -g jscs
}

main(){
  install_utils
  install_emacs
  install_ctags
  install_hunspell
  install_php_utils
  install_node
  install_bower
  install_gulp
  install_eslint
  install_jshint
  install_jscs
  install_emacs_packages
  create_ide_shortcut
}

main
