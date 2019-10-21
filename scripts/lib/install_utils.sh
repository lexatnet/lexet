#!/bin/bash

install_bower(){
  local cache='~/.npm'
  local global_config=''
  local user_config=''
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --cache)
        cache=$2
        shift # past value
        ;;
      --npm-global-config)
        global_config=$2
        shift # past argument
        shift # past value
        ;;
      --npm-user-config)
        user_config=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  echo "prefix = ${prefix}"
  npm config set cache $cache

  npm --globalconfig $global_config --userconfig $user_config install --global bower
  npm cache clean
  cd $cwd
}

install_gulp(){
  local cache='~/.npm'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --cache)
        cache=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  npm config set cache $cache
  npm install --global gulp
  npm cache clean
  cd $cwd
}

install_eslint(){
  local cache='~/.npm'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --cache)
        cache=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  npm config set cache $cache
  npm install --global eslint
  npm install --global babel-eslint
  eslint --init
  npm cache clean
  cd $cwd
}

install_jshint(){
  local cache='~/.npm'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --cache)
        cache=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  npm config set cache $cache
  npm install --global jshint
  npm cache clean
  cd $cwd
}

install_jscs(){
  local cache='~/.npm'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --cache)
        cache=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  npm config set cache $cache
  npm install --global jscs
  npm cache clean
  cd $cwd
}

install_prettier(){
  local cache='~/.npm'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --cache)
        cache=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  npm config set cache $cache
  npm install --global prettier
  npm cache clean
  cd $cwd
}


install_utils(){
  local root=''
  local args=("$@")
  local cwd=$(pwd)
  local home=$cwd

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --root)
        root=$2
        shift # past value
        ;;
      --init-script)
        init_script=$2
        shift # past argument
        shift # past value
        ;;
      --home)
        home=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  nvm_init_script=$root/init/nvm.sh
  nvm_root=$root/env/nvm
  npm_global_config=$nvm_root/.npmrc
  app_run_nvm_dir='${LEXET_MOUNT_POINT}/env/nvm'
  app_run_rbenv_dir='${LEXET_MOUNT_POINT}/env/rbenv'
  install_nvm --nvm-root $nvm_root --init-script $nvm_init_script --init-nvm-root $app_run_nvm_dir
  local cache=$(nvm cache dir)
  local HOME=$home
  local default_packages=$nvm_root/default-packages
  cat > ${default_packages} <<EOF
gulp
eslint
jshint
jscs
prettier
EOF

  install_node --nvm-root $nvm_root

  # npm config get prefix
  # echo "NPM_CONFIG_PREFIX=$NPM_CONFIG_PREFIX"
  # echo "NVM_NPM_CONFIG_PREFIX_ENV=$NVM_NPM_CONFIG_PREFIX_ENV"

  # install_bower --cache $cache --npm-global-config $npm_global_config --npm-user-config $npm_global_config
  # install_gulp --cache $cache
  # install_eslint --cache $cache
  # install_jshint --cache $cache
  # install_jscs --cache $cache
  # install_prettier --cache $cache
  install_ruby --rbenv-root $root/env/rbenv --init-script $root/init/rbenv.sh --prefix $root --init-rbenv-root app_run_rbenv_dir
  cd $cwd
}
