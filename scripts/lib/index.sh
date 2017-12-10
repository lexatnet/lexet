#!/bin/bash
echo "Library directory \"$lib_dir\""
echo 'Libs loading.......'

source $lib_dir/try.sh
source $lib_dir/trim.sh
source $lib_dir/generate_sshd_config.sh
source $lib_dir/generate_ide_user_profile.sh

echo 'Libs loaded.'
