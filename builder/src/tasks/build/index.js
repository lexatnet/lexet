const del = require('del');
const gulp = require('gulp');

require('@tasks/prepare-python')
require('@tasks/prepare-node')
require('@tasks/prepare-lexet')
require('@tasks/build-appimage')
require('@tasks/prepare-appdir')

gulp.task('build', gulp.series(
  'prepare-appdir',
  'prepare-python',
  'prepare-lexet',
  'build-appimage'
))
