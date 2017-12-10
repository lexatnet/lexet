#!bin/bash

generate_project_name(){
  local data=$1
  local project_name=$(trim -s ${data//\//\.}  -c ' /.')
  echo $project_name
}

project_external_dir=${1:-$(pwd)}
project_name=$(generate_project_name $project_external_dir)
echo "project name \"$project_name\""
ide_tmp_external_dir_default=/tmp/ide/$project_name
ide_tmp_external_dir=${2:-$ide_tmp_external_dir_default}

echo "project=${project_external_dir}"
echo "tmp=${ide_tmp_external_dir}"

# TODO: fix project directory trailing slash
# TODO: Add project name to emacs environment to display in window title

if [ -z $ide_external_root ]
then
  ide_project_external_dir=$project_external_dir/${ide_project_dir_name}/data
  ide_packages_external_dir=$project_external_dir/${ide_project_dir_name}/$ide_packages_dir_name
else
  ide_project_external_dir=$ide_external_root/projects/$project_name
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
  ssh-keygen -t rsa -N "" -C "ide-host-rsa-key" -f $ide_key_external_dir/$ide_ssh_host_rsa_key_name
  ssh-keygen -t dsa -N ""  -C "ide-host-dsa-key" -f $ide_key_external_dir/$ide_ssh_host_dsa_key_name
  ssh-keygen -t ecdsa -N "" -C "ide-host-ecdsa-key" -f $ide_key_external_dir/$ide_ssh_host_ecdsa_key_name
  ide_home_ssh_external_dir=$ide_home_external_dir/.ssh
  [ -d $ide_home_ssh_external_dir ] || mkdir --parent --verbose $ide_home_ssh_external_dir
  ln -s $ide_key_external_pub $ide_home_ssh_external_dir/authorized_keys
fi
