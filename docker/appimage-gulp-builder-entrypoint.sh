#!/usr/bin/env bash

echo 'building lexet appimage'
source /init/nvm.sh
cd /builder
nvm install
nvm use
npm install
npx gulp
