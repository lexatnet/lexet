#!/bin/bash

echo 'building lexet appimage'

echo 'PWD='$(pwd)

apt-get update
apt-get install -y wget
apt-get install -y desktop-file-utils
apt-get install -y file
export DEBIAN_FRONTEND=noninteractive
#TZ= Asia/Omsk
#install tzdata package
apt-get install -y tzdata
# set your timezone
ln -fs /usr/share/zoneinfo/Asia/Omsk /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
apt-get install -y glib2.0
rm -rf /var/lib/apt/lists/*

cd $through_point

echo 'PWD='$(pwd)

wget -O - https://raw.githubusercontent.com/AppImage/pkg2appimage/master/pkg2appimage | bash -s -- ./recipe.yml
