#!/bin/bash

install_ruby() {
  local rbenv_root=''
  local init_script='/etc/profile.d/rbenv.sh'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      --rbenv-root)
        rbenv_root=$2
        shift # past argument
        shift # past value
        ;;
      --init-script)
        init_script=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  git clone https://github.com/rbenv/rbenv.git $rbenv_root
  git clone https://github.com/rbenv/ruby-build.git $rbenv_root/plugins/ruby-build
  $rbenv_root/plugins/ruby-build/install.sh
  echo '# rbenv setup' > $init_script
  echo "export RBENV_ROOT=${rbenv_root}" >> $init_script
  echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> $init_script
  echo 'eval "$(rbenv init -)"' >> $init_script # or /etc/profile

  #install for non-login bash sesionsru
  #echo "source $init_script" >> /etc/bash.bashrc

  source $init_script

  RUBY_VERSION=$(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
  rbenv install $RUBY_VERSION
  rbenv global $RUBY_VERSION
  gem install bundler
  gem install rubocop
  gem install rubocop-rspec
  gem install ruby-lint
  cd $cwd
}
