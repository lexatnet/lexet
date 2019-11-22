#!/bin/bash

install_nvm(){
  local nvm_root=''
  local init_nvm_root=$nvm_root
  local init_script='/etc/profile.d/nvm.sh'
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --nvm-root)
        nvm_root=$2
        shift # past value
        ;;
      --init-nvm-root)
        init_nvm_root=$2
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

  git clone https://github.com/nvm-sh/nvm.git $nvm_root
  cd $nvm_root
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`

  cat > ${init_script} <<EOF
export NVM_DIR=${init_nvm_root}
[ -s "${init_nvm_root}/nvm.sh" ] && \. "${init_nvm_root}/nvm.sh"
[ -s "${init_nvm_root}/bash_completion" ] && \. "${init_nvm_root}/bash_completion"  # This loads nvm bash_completion
EOF

  export NVM_DIR=${nvm_root}
  [ -s ${nvm_root}/nvm.sh ] && \. ${nvm_root}/nvm.sh

  cd $cwd
}
