#!/bin/bash

try() {
  local command=$1
  local try_times=$2
  local delay=15
  local try_count=0
  until [ $try_count -ge $try_times ]
  do
    ($command) && break
    try_count=$[$try_count+1]
    sleep $delay
  done
}
