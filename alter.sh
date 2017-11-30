#!/bin/bash


useraddOptions="--no-create-home --no-user-group --shell /bin/bash --home-dir ${ide_home}"

user=$USER
uid=$user_id
gid=$group_id

if [ -n "$uid" ]; then
  useraddOptions="$useraddOptions --non-unique --uid $uid"
fi

if [ -n "$gid" ]; then
  if ! $(cat /etc/group | cut -d: -f3 | grep -q "$gid"); then
    groupadd --gid $gid $gid
  fi

  useraddOptions="$useraddOptions --gid $gid"
fi

useradd $useraddOptions $user

su --command "/usr/sbin/sshd -D -e -f $through_point/$sshd_config" $user



