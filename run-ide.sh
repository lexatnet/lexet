#!/bin/bash

dir="$(cd "$(dirname "$(readlink -f  "$0")")" && pwd)"
source $dir/config.sh


project_dir=${1:-$(pwd)}
tmp_files_dir=${2:-'/tmp'}

echo "project =${project_dir}"

docker run \
       --label "label=${label}" \
       --volume $project_dir:$mount_point \
       --volume $dir/$emacs_config:$through_point/$emacs_config \
       --volume $dir/$ctags_exclude_config:$through_point/$ctags_exclude_config \
       --volume $tmp_files_dir:$through_point/$ide_tmp_dir \
       --volume $volume:$storage \
       --env-file $root/$env_config \
       --workdir $workdir \
       --interactive \
       --tty \
       --rm \
       $image_name
