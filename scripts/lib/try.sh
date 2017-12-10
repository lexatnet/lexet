#!/bin/bash

try() {
  local command=$1
  local try_times=$2
  local delay=15
  local try_count=0
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
