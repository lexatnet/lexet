#!/bin/bash

echo 'building lexet appimage'

cd $through_point

PKG2AIREPO=lexatnet/pkg2appimage
# PKG2AIREPO=AppImage/pkg2appimage
PKG2AICOMMIT=master

wget -O - https://raw.githubusercontent.com/${PKG2AIREPO}/${PKG2AICOMMIT}/pkg2appimage |\
  PKG2AICOMMIT=$PKG2AICOMMIT \
  PKG2AIREPO=$PKG2AIREPO \
  ARCH=x86_64 \
  bash -s -- ./recipe.yml

# wget -O - https://raw.githubusercontent.com/AppImage/pkg2appimage/master/pkg2appimage |\
#   ARCH=x86_64 \
#   bash -s -- ./recipe.yml
