#!bin/bash

project_dir=${1:-$(pwd)}
tmp_files_dir=${2:-/tmp/ide/$project_dir}

echo "project=${project_dir}"
echo "ide_tmp_dir=${through_point}/${ide_tmp_dir}"

[ -d $tmp_files_dir ] || mkdir --parent --verbose $tmp_files_dir
[ -d $ide_project_dir ] || mkdir --parent --verbose $ide_project_dir
[ -d $ide_home ] || mkdir --parent --verbose $ide_home
[ -d $ide_server_dir ] ||mkdir --mode=600 $ide_server_dir
