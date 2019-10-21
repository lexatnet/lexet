#!/bin/bash

echo 'building lexet appimage'

cd $through_point

wget -O - https://raw.githubusercontent.com/AppImage/pkg2appimage/master/pkg2appimage | ARCH=x86_64 bash -s -- ./recipe.yml
