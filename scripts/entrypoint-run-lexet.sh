#!/bin/bash

source $through_point/lib/index.sh

if [ -d $through_point/init ]; then
  for i in $through_point/init/*.sh; do
    if [ -r $i ]; then
      echo $i
      . $i
    fi
  done
  unset i
fi

lexet
