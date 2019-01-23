#!/bin/bash

source $through_point/lib/index.sh

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

install_emacs_packages(){
  emacs -q --load "$through_point/$emacs_config" --batch --kill
}

init(){
  install_node --nvm-root $through_point/env/nvm --init-script $through_point/init/nvm.sh
  install_bower
  install_gulp
  install_eslint
  install_jshint
  install_jscs
  install_ruby --rbenv-root $through_point/env/rbenv --init-script $through_point/init/rbenv.sh
  install_emacs_packages
}

init
