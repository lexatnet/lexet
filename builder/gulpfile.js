require('module-alias/register');

const { get } = require('lodash');
const config = require('@config');
const appDir = get(config, 'appDir');
process.env['APPDIR'] = appDir;

const gulp = require('gulp');

require('@tasks/clean');
// require('@tasks/experiment');
require('@tasks/prepare-appdir');
require('@tasks/prepare-node');
require('@tasks/prepare-python');
require('@tasks/prepare-ruby');
require('@tasks/prepare-php');
require('@tasks/prepare-ctags');
require('@tasks/prepare-hunspell');
require('@tasks/prepare-atom');
require('@tasks/prepare-lexet');
require('@tasks/build-appimage');

gulp.task('build', gulp.series(
  'prepare-appdir',
  'prepare-node',
  'prepare-python',
  'prepare-ruby',
  'prepare-php',
  'prepare-ctags',
  'prepare-hunspell',
  'prepare-atom',
  'prepare-lexet',
  'build-appimage'
));

exports.default = gulp.series('clean', 'build');
