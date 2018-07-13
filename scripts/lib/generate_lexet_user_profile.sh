#!/bin/bash

generate_lexet_user_profile() {
cat <<EOL
export USER=$USER
export HOME=$lexet_home
export lexet_home=$lexet_home
export lexet_server_dir=$lexet_server_dir
export lexet_tmp_dir=$lexet_tmp_dir
export lexet_packages_dir=$lexet_packages_dir
export mount_point=$mount_point
export through_point=$through_point
export sshd_config=$sshd_config
export emacs_config=$emacs_config
export group_id=$group_id
export project_name=$project_name
export lexet_tags_dir=$lexet_tags_dir

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
