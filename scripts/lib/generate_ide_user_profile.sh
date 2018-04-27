#!/bin/bash

generate_ide_user_profile() {
cat <<EOL
export USER=$USER
export HOME=$ide_home
export ide_home=$ide_home
export ide_server_dir=$ide_server_dir
export ide_tmp_dir=$ide_tmp_dir
export ide_packages_dir=$ide_packages_dir
export mount_point=$mount_point
export through_point=$through_point
export sshd_config=$sshd_config
export emacs_config=$emacs_config
export group_id=$group_id

if [ -d $through_point/init ]; then
  for i in $through_point/init/*.sh; do
    if [ -r \$i ]; then
      . \$i
    fi
  done
  unset i
fi

EOL
}
