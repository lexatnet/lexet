#!/usr/bin/env bash

copy_libs(){
  local destination=''
  local source=''
  local libs_list=()
  local args=("$@")
  local cwd=$(pwd)

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --destination)
        destination=$2
        shift # past value
        shift # past value
        ;;
      --src)
        source=$2
        shift # past value
        shift # past value
        ;;
      --lib)
        libs_list+=($2)
        shift # past value
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  for lib in "${libs_list[@]}"; do
    local lib_path="${source}/${lib}"
    local real_file=$(readlink -f "${lib_path}")
    local name=$(basename ${real_file})
    if [[ -f "${lib_path}" ]]; then
      echo "copy ${lib_path} to ${destination}/${lib}"
      cp "${lib_path}" "${destination}/${lib}"
    fi
    if [[ -f "${real_file}" ]]; then
      echo "copy ${real_path} to ${destination}/${name}"
      cp "${real_file}" "${destination}/${name}"
    fi
  done;

  cd $cwd
}
