#!bin/bash

project_external_dir=${1:-$(pwd)}
ide_tmp_external_dir=${2:-/tmp/ide/${project_external_dir//\//\.}}

echo "project=${project_external_dir}"
echo "tmp=${ide_tmp_external_dir}"

if [ -z $ide_external_root ]
then
  ide_project_external_dir=$project_external_dir/${ide_project_dir_name}/data
  ide_packages_external_dir=$project_external_dir/${ide_project_dir_name}/$ide_packages_dir_name
else
  ide_project_external_dir=$ide_external_root/projects/${project_external_dir//\//\.}
  ide_packages_external_dir=$ide_external_root/$ide_packages_dir_name
fi

ide_home_external_dir=$ide_project_external_dir/$ide_home_dir_name
ide_key_external_dir=$ide_project_external_dir/.ssh
ide_key_external=$ide_key_external_dir/$ide_key_name
ide_key_external_pub=$ide_key_external.pub
ide_server_external_dir=$ide_project_external_dir/$ide_server_dir_name

ide_project_dir=${through_point}/${ide_project_dir_name}
ide_packages_dir=${through_point}/$ide_packages_dir_name
ide_home=${ide_project_dir}/$ide_home_dir_name
ide_server_dir=${ide_project_dir}/$ide_server_dir_name


[ -d $ide_tmp_external_dir ] || mkdir --parent --verbose $ide_tmp_external_dir
[ -d $ide_packages_external_dir ] || mkdir --parent --verbose $ide_packages_external_dir
[ -d $ide_project_external_dir ] || mkdir --parent --verbose $ide_project_external_dir
[ -d $ide_home_external_dir ] || mkdir --parent --verbose $ide_home_external_dir
[ -d $ide_server_external_dir ] || mkdir --mode=700 $ide_server_external_dir

echo "Checking ssh keys dir ${ide_key_external_dir}"

if [ ! -d $ide_key_external_dir ]
then
  echo "Creating ssh keys"
  mkdir --parent --verbose $ide_key_external_dir
  ssh-keygen -b 2048 -t rsa -N "" -C "ide-host-key" -f $ide_key_external_dir/$ide_key_name
  ssh-keygen -t rsa -N -f $ide_key_external_dir/ssh_host_rsa_key
  ssh-keygen -t dsa -N -f $ide_key_external_dir/ssh_host_dsa_key
  ssh-keygen -t ecdsa -N -f $ide_key_external_dir/ssh_host_ecdsa_key
  ide_home_ssh_external_dir=$ide_home_external_dir/.ssh
  [ -d $ide_home_ssh_external_dir ] || mkdir --parent --verbose $ide_home_ssh_external_dir
  ln -s $ide_key_external_pub $ide_home_ssh_external_dir/authorized_keys
fi
