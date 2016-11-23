#!/bin/bash

apt-get update && apt-get install -y software-properties-common

apt-add-repository ppa:ubuntu-elisp/ppa

apt-get update && apt-get install -y \
        emacs-snapshot \
        mc

apt-get update
apt-get install -y git 
apt-get install -y make
apt-get install -y autoconf
apt-get install -y pkg-config

apt-get install -y php-cli 
apt-get install -y cscope

#install ctags from sources
cd /tmp
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh 
./configure
make
make install

/tmp/run-emacs.sh --batch --kill
