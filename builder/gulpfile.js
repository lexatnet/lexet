require('module-alias/register');

const gulp = require('gulp');

require('@tasks/build');
require('@tasks/clean');
require('@tasks/build-appimage');
require('@tasks/experiment');
require('@tasks/prepare-atom');
require('@tasks/prepare-ctags');
require('@tasks/prepare-hunspell');

gulp.task('build', gulp.series(
  'clean',
  'prepare-appdir',
  'create-symlinks',
  'prepare-node',
  'prepare-python',
  'prepare-ctags',
  'prepare-hunspell',
  'prepare-atom',
  'prepare-lexet',
  'build-appimage'
));

exports.default = gulp.series('clean', 'build');
