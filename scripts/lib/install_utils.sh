#!/bin/bash

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

  install_nvm \
    --nvm-root $nvm_root \
    --init-script $nvm_init_script \
    --init-nvm-root $app_run_nvm_dir

  # local cache=$(nvm cache dir)
  local HOME=$home
  local default_packages=$nvm_root/default-packages

  cat > ${default_packages} <<EOF
gulp
eslint
babel-eslint
jshint
jscs
prettier
@prettier/plugin-xml
EOF

  install_node \
    --nvm-root $nvm_root

  # npm config get prefix
  # echo "NPM_CONFIG_PREFIX=$NPM_CONFIG_PREFIX"
  # echo "NVM_NPM_CONFIG_PREFIX_ENV=$NVM_NPM_CONFIG_PREFIX_ENV"

  install_ruby \
    --rbenv-root $root/env/rbenv \
    --init-script $root/init/rbenv.sh \
    --prefix $root \
    --init-rbenv-root $app_run_rbenv_dir

  cd $cwd
}
