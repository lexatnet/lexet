#!/bin/bash

source $through_point/lib/index.sh

if [ -d $through_point/init ]; then
  for i in $through_point/init/*.sh; do
    if [ -r $i ]; then
      echo $i
      echo "source $i" >> /etc/profile
      echo "source $i" >> /etc/bash.bashrc
    fi
  done
  unset i
fi

add_user --user $USER --uid $user_id  --gid $group_id --user-home $lexet_home

su --command "/usr/sbin/sshd -D -e -f $through_point/$sshd_config" $USER

bash
