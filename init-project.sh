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
