#!/bin/bash

install_ruby() {
  local rbenv_root=''
  local init_rbenv_root=$rbenv_root
  local init_script='/etc/profile.d/rbenv.sh'
  local args=("$@")
  local cwd=$(pwd)
  local prefix=/usr/local/share/

  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      --rbenv-root)
        rbenv_root=$2
        shift # past argument
        shift # past value
        ;;
      --init-rbenv-root)
        init_rbenv_root=$2
        shift # past argument
        shift # past value
        ;;
      --init-script)
        init_script=$2
        shift # past argument
        shift # past value
        ;;
      --prefix)
        prefix=$2
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
  PREFIX=$prefix $rbenv_root/plugins/ruby-build/install.sh

  cat > ${init_script} <<EOF
# rbenv setup
export RBENV_ROOT=${init_rbenv_root}
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
ruby_lib="$(rbenv which ruby | grep versions | sed 's/bin\/ruby/lib/')"
ruby_load_path="$(rbenv which ruby | grep versions | sed 's/bin\/ruby/lib\/ruby\/2\.6\.0/')"
export LOAD_PATH="$ruby_load_path/:\$LOAD_PATH"
#export LD_LIBRARY_PATH="$ruby_lib:$LD_LIBRARY_PATH"
EOF


  #install for non-login bash sesionsru
  #echo "source $init_script" >> /etc/bash.bashrc

  export RBENV_ROOT=${rbenv_root}
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"


  RUBY_VERSION=$(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
  rbenv install $RUBY_VERSION
  rbenv global $RUBY_VERSION
  gem install bundler
  gem install rubocop
  gem install rubocop-rspec
  gem install ruby-lint

  #rbenv rehash

  substritution_init_rbenv_root=$(echo ${init_rbenv_root} |  sed 's/\//\\\//g' |  sed 's/\$/\\\$/g')
  substritution_rbenv_root=$(echo ${rbenv_root} |  sed 's/\//\\\//g' |  sed 's/\$/\\\$/g')

  grep -rl ${rbenv_root} ${rbenv_root}/shims | xargs -i@ sed -i "s/${substritution_rbenv_root}/${substritution_init_rbenv_root}/" @

  grep -rl ${rbenv_root} ${rbenv_root}/versions  --exclude-dir=lib --exclude=ruby | xargs -i@ sed -i "s/${substritution_rbenv_root}\/.*\/ruby/\/usr\/bin\/env ruby/" @

  cd $cwd
}
