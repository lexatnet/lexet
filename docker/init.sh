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
source $dir/../config/config.sh

install_utils(){
  echo -e '\n------install_utils------\n'

  apt-get update
  # set noninteractive installation
  export DEBIAN_FRONTEND=noninteractive
  #TZ= Asia/Omsk
  #install tzdata package
  apt-get install -y tzdata
  # set your timezone
  ln -fs /usr/share/zoneinfo/Asia/Omsk /etc/localtime
  dpkg-reconfigure --frontend noninteractive tzdata


  apt-get install -y software-properties-common
  apt-get install -y mc

  echo -e '\n------install git------\n'
  apt-get install -y git
  echo -e '\n------install make------\n'
  apt-get install -y make
  echo -e '\n------install autoconf------\n'
  apt-get install -y autoconf
  echo -e '\n------install pkg-config------\n'
  apt-get install -y pkg-config
  echo -e '\n------install php-cli------\n'
  apt-get install -y php-cli
  echo -e '\n------install cscope------\n'
  apt-get install -y cscope

  echo -e '\n------install curl------\n'
  apt-get install -y curl

  echo -e '\n------install language-pack-en-base------\n'
  apt-get install -y language-pack-en-base

  #for rbenv & ruby
  echo -e '\n------install language-pack-en-base------\n'
  apt-get install -y libssl-dev libreadline-dev zlib1g-dev
}

install_ssh(){
  echo -e '\n------install_ssh------\n'
  apt-get install -y openssh-server
  mkdir -vp /var/run/sshd
}

install_emacs(){
  echo -e '\n------install_emacs------\n'
  apt-add-repository ppa:ubuntu-elisp/ppa
  apt-get update
  apt-get install -y emacs-snapshot
}

install_pylint(){
  echo -e '\n------install_pylint------\n'
  apt-get install -y pylint3
}

install_shellcheck(){
  echo -e '\n------install_shellcheck------\n'
  apt-get install shellcheck
}

install_ctags(){
  echo -e '\n------install_ctags-----\n'
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
  echo -e '\n------install_hunspell-----\n'

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

get_lexet_init_piont_script() {
cat <<EOL

#lexet init point
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
  echo -e '\n------install_php_utils-----\n'
  cd $dist_point
  curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
  php phpcs.phar -h

  curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
  php phpcbf.phar -h

  # clear
  rm phpcs.phar
  rm phpcbf.phar
}

create_lexet_shortcut(){
  echo -e '\n------create_lexet_shortcut-----\n'
  ln -s "$dist_point/docker/run-emacs.sh" /usr/bin/lexet
}

#configure_ssh(){
  #sed -i '/<pattern>/s/^#//g' /etc/ssh/ssh_config
  #echo 'X11Forwarding yes' >> /etc/ssh/ssh_config
  #echo 'X11UseForwarding yes' >> /etc/ssh/ssh_config
#}

configure_bash() {
  echo -e '\n------configure_bash-----\n'
  get_lexet_init_piont_script >> /etc/profile
  get_lexet_init_piont_script >> /etc/bash.bashrc
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
  create_lexet_shortcut
  configure_bash
  #configure_ssh
}

main
