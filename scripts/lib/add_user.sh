#!/bin/bash

add_user() {
  local user=''
  local user_home=''
  local gid=''
  local args=("$@")

  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      --user)
        user=$2
        shift # past argument
        shift # past value
        ;;
      --user-home)
        user_home=$2
        shift # past argument
        shift # past value
        ;;
      --uid)
        uid=$2
        shift # past argument
        shift # past value
        ;;
      --gid)
        gid=$2
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters
  useraddOptions="--no-create-home --no-user-group --shell /bin/bash --home-dir ${user_home}"


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
}
