#!bin/bash

generate_project_name(){
  local data=$1
  local project_name=$(trim -s ${data//\//\.}  -c ' /.')
  echo $project_name
}

project_external_dir=${1:-$(pwd)}
project_name=$(generate_project_name $project_external_dir)
echo "project name \"$project_name\""
lexet_tmp_external_dir_default=/tmp/lexet/$project_name
lexet_tmp_external_dir=${2:-$lexet_tmp_external_dir_default}

echo "project=${project_external_dir}"
echo "tmp=${lexet_tmp_external_dir}"

if [ -z $lexet_external_root ]
then
  lexet_project_external_dir=$project_external_dir/${lexet_project_dir_name}/data
  lexet_vendor_packages_external_dir=$project_external_dir/${lexet_project_dir_name}/$lexet_vendor_packages_dir_name
else
  lexet_project_external_dir=$lexet_external_root/projects/$project_name
  lexet_vendor_packages_external_dir=$lexet_external_root/$lexet_vendor_packages_dir_name
fi

lexet_home_external_dir=$lexet_project_external_dir/$lexet_home_dir_name
lexet_key_external_dir=$lexet_project_external_dir/.ssh
lexet_key_external=$lexet_key_external_dir/$lexet_key_name
lexet_key_external_pub=$lexet_key_external.pub
lexet_server_external_dir=$lexet_project_external_dir/$lexet_server_dir_name

lexet_project_dir=${through_point}/${lexet_project_dir_name}
lexet_packages_dir=${through_point}/$lexet_packages_dir_name
lexet_vendor_packages_dir=${through_point}/$lexet_vendor_packages_dir_name
lexet_utils_dir=${through_point}/$lexet_utils_dir_name
lexet_home=${lexet_project_dir}/$lexet_home_dir_name
lexet_server_dir=${lexet_project_dir}/$lexet_server_dir_name
lexet_tags_dir=${lexet_project_dir}/tags

[ -d $lexet_tmp_external_dir ] || mkdir --parent --verbose $lexet_tmp_external_dir
[ -d $lexet_vendor_packages_external_dir ] || mkdir --parent --verbose $lexet_vendor_packages_external_dir
[ -d $lexet_project_external_dir ] || mkdir --parent --verbose $lexet_project_external_dir
[ -d $lexet_home_external_dir ] || mkdir --parent --verbose $lexet_home_external_dir
[ -d $lexet_server_external_dir ] || mkdir --mode=700 $lexet_server_external_dir

echo "Checking ssh keys dir ${lexet_key_external_dir}"


if [ ! -d $lexet_key_external_dir ]
then
  echo "Creating ssh keys"
  mkdir --parent --verbose $lexet_key_external_dir
  ssh-keygen -b 2048 -t rsa -N "" -C "lexet-host-key" -f $lexet_key_external_dir/$lexet_key_name
  ssh-keygen -t rsa -N "" -C "lexet-host-rsa-key" -f $lexet_key_external_dir/$lexet_ssh_host_rsa_key_name
  ssh-keygen -t dsa -N ""  -C "lexet-host-dsa-key" -f $lexet_key_external_dir/$lexet_ssh_host_dsa_key_name
  ssh-keygen -t ecdsa -N "" -C "lexet-host-ecdsa-key" -f $lexet_key_external_dir/$lexet_ssh_host_ecdsa_key_name
  lexet_home_ssh_external_dir=$lexet_home_external_dir/.ssh
  [ -d $lexet_home_ssh_external_dir ] || mkdir --parent --verbose $lexet_home_ssh_external_dir
  ln -s $lexet_key_external_pub $lexet_home_ssh_external_dir/authorized_keys
fi
