#!/bin/bash

try() {
  local command=$1
  local try_times=$2
  local delay=15
  local try_count=0

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --command)
        command=$2
        shift # past argument
        shift # past value
        ;;
      --try-times)
        try_times=$2
        shift # past argument
        shift # past value
        ;;
      --delay)
        delay=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  
  echo "try command '$command'"
  until [ $try_count -ge $try_times ]
  do
    echo "try to run $try_count"
    ($command)
    if [ $? -eq 0 ]
    then
      break
    fi
    try_count=$[$try_count+1]
    echo "sleeping $delay"
    sleep $delay
  done
}
