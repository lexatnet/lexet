#!/usr/bin/env bash

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


images=(
  alpine:latest
  archlinux:latest
  fedora:latest
  debian:latest
  ubuntu:latest
)

session=$(echo ${DBUS_SESSION_BUS_ADDRESS} | sed -e 's/\(unix:path=\)//g')


test_appimage() {
  dir=$(get_script_dir)
  source $dir/../config/config.sh
  staff_tests_dir=${root}/staff/tests
  tests_home_dir=${staff_tests_dir}/home
  tests_cache_dir=${staff_tests_dir}/.pytest_cache

  echo "-------------------run tests in $1--------------------------"

  [ -d $staff_tests_dir ] || mkdir $staff_tests_dir
  [ -d $tests_home_dir ] || mkdir $tests_home_dir
  [ -d $tests_cache_dir ] || mkdir $tests_cache_dir

  docker run \
    --volume $root/staff/build/workspace/AppDir:/app:ro \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume $root/scripts/tests.sh:/tests.sh:ro \
    --volume $session:$session:rw \
    --volume $tests_home_dir:/home:rw \
    --volume $tests_cache_dir:/.pytest_cache:rw \
    -e through_point=$through_point \
    -e LEXET_MOUNT_POINT=$through_point \
    -e DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
    -e DISPLAY=$DISPLAY \
    -e XDG_DATA_DIRS=/usr/share:/usr/local/share \
    -e HOME=/home \
    --user $(id -u ${USER}):$(id -g ${USER}) \
    --rm \
    --entrypoint='/app/bin/bash' \
    $1 \
    /tests.sh

  [ -d $staff_tests_dir ] && echo 'clean tests staff' && rm -rf $staff_tests_dir

  echo "---------------------------------------------"
}


for image in ${images[@]}; do
  test_appimage $image
done
