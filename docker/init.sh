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

  #for rbenv & ruby
  apt-get install -y libssl-dev libreadline-dev zlib1g-dev
}

install_ssh(){
  apt-get install -y openssh-server
  mkdir -vp /var/run/sshd
}

install_emacs(){
  apt-add-repository ppa:ubuntu-elisp/ppa
  apt-get update
  apt-get install -y emacs-snapshot
}

install_pylint(){
  apt-get install -y pylint3
}

install_shellcheck(){
  apt-get install shellcheck
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

get_ide_init_piont_script() {
cat <<EOL

#ide init point
if [ -d $through_point/init ]; then
  for i in $through_point/init/*.sh; do
    if [ -r \$i ]; then
      . \$i
    fi
  done
  unset i
fi

EOL
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

create_ide_shortcut(){
  ln -s "$dist_point/docker/run-emacs.sh" /usr/bin/ide
}

#configure_ssh(){
  #sed -i '/<pattern>/s/^#//g' /etc/ssh/ssh_config
  #echo 'X11Forwarding yes' >> /etc/ssh/ssh_config
  #echo 'X11UseForwarding yes' >> /etc/ssh/ssh_config
#}

configure_bash() {
  get_ide_init_piont_script >> /etc/profile
  get_ide_init_piont_script >> /etc/bash.bashrc
}

main(){
  install_utils
  install_ssh
  install_emacs
  install_ctags
  install_hunspell
  install_pylint
  install_shellcheck
  install_php_utils
  create_ide_shortcut
  configure_bash
  #configure_ssh
}

main
