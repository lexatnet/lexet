#!bin/bash

project_external_dir=${1:-$(pwd)}
ide_tmp_external_dir=${2:-/tmp/ide/${project_external_dir//\//\.}}

echo "project=${project_external_dir}"
echo "tmp=${ide_tmp_external_dir}"

if [ -z $ide_external_projects_dirs_root ]
then
  ide_project_external_dir=$project_external_dir
else
  ide_project_external_dir=$ide_external_projects_dirs_root/${project_external_dir//\//\.}
fi

ide_home_external_dir=$ide_project_external_dir/home
ide_server_external_dir=$ide_project_external_dir/server

ide_project_dir=${through_point}/${ide_project_dir_name}
ide_home=${ide_project_dir}/home
ide_server_dir=${ide_project_dir}/server

[ -d $ide_tmp_external_dir ] || mkdir --parent --verbose $ide_tmp_external_dir
[ -d $ide_project_external_dir ] || mkdir --parent --verbose $ide_project_external_dir
[ -d $ide_home_external_dir ] || mkdir --parent --verbose $ide_home_external_dir
[ -d $ide_server_external_dir ] || mkdir --mode=700 $ide_server_external_dir
