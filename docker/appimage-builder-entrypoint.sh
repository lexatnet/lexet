#!/bin/bash

echo 'building lexet appimage'

cd $through_point

wget -O - https://raw.githubusercontent.com/AppImage/pkg2appimage/master/pkg2appimage | bash -s -- ./recipe.yml
