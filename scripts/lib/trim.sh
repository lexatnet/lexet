#!/bin/bash

trim(){
  local in_string=''
  local characters=' /'
  local args=("$@")

  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      -s|--string)
        in_string=$2
        shift # past argument
        shift # past value
        ;;
      -c|--characters)
        characters=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters
  local processing_string=$in_string
  local sed_group=''
  local specials='+./'
  for i in $(seq 1 ${#characters})
  do
    local character=${characters:i-1:1}
    if [[ $specials == *$character* ]];
    then
      character="\\$character"
    fi
    sed_group="$sed_group[$character]*"
  done
  sed_group="($sed_group)*"
  sed_script="s~^$sed_group|$sed_group$~~g"
  processing_string=$(echo -e $processing_string | sed -E "$sed_script")

  echo $processing_string
}

