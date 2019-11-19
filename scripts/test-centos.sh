#!/bin/bash


get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}

dir=$(get_script_dir)
source $dir/../config/config.sh

docker run \
       --label "label=test-centos" \
       --volume $root/build/out:$through_point:ro \
       -e through_point=$through_point \
       --workdir $through_point \
       --interactive \
       --tty \
       --rm \
       --user $(id -u ${USER}):$(id -g ${USER}) \
       --entrypoint /bin/bash \
       centos
