require('module-alias/register');

const gulp = require('gulp');

require('@tasks/clean');
// require('@tasks/experiment');
require('@tasks/prepare-appdir');
require('@tasks/prepare-node');
require('@tasks/prepare-python');
require('@tasks/prepare-ctags');
require('@tasks/prepare-hunspell');
require('@tasks/prepare-atom');
require('@tasks/prepare-lexet');
require('@tasks/build-appimage');

gulp.task('build', gulp.series(
  'prepare-appdir',
  'prepare-node',
  'prepare-python',
  'prepare-ctags',
  'prepare-hunspell',
  'prepare-atom',
  'prepare-lexet',
  'build-appimage'
));

exports.default = gulp.series('clean', 'build');
