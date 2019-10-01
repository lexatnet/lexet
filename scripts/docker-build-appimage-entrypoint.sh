#!/bin/bash

echo 'building lexet appimage'

echo 'PWD='$(pwd)

apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

cd $through_point

echo 'PWD='$(pwd)

wget -O - https://raw.githubusercontent.com/AppImage/pkg2appimage/master/pkg2appimage | bash -s -- ./recipe.yml
