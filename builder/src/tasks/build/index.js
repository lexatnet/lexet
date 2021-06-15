// require('module-alias/register')

const del = require('del');
const gulp = require('gulp');

const { preparePython } = require('@tasks/prepare-python')
const { installNvm } = require('@tasks/install-nvm')
const { prepareLexet } = require('@tasks/prepare-lexet')
const { buildAppimage } = require('@tasks/build-appimage')
const { prepareAppimageDirTree } = require('@tasks/prepare-appimage-dir-tree')

gulp.task('install-nvm', installNvm)

exports.build = gulp.series(
  prepareAppimageDirTree,
  preparePython,
  prepareLexet,
  // buildAppimage
)
