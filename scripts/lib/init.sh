#!/bin/bash

source $through_point/lib/index.sh

install_bower(){
  npm install --global bower
}

install_gulp(){
  npm install --global gulp
}

install_eslint(){
  npm install --global eslint
  npm install --global babel-eslint
  eslint --init
}

install_jshint(){
  npm install --global jshint
}

install_jscs(){
  npm install --global jscs
}

install_prettier(){
  npm install --global prettier
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
  install_prettier
  install_ruby --rbenv-root $through_point/env/rbenv --init-script $through_point/init/rbenv.sh
  install_emacs_packages
}

init
