const gulp = require('gulp');
require('./get-python-sources');
require('./extract-python-sources');
require('./configure-python');
require('./make-python');
require('./install-python');
require('./setup-python-packages');
require('./patch-python-interpreter');
require('./prepare-python-executables-packages');
require('./create-python-symlinks');

gulp.task('build-python', gulp.series(
  'configure-python',
  'make-python'
));

gulp.task('prepare-python', gulp.series(
  'get-python-sources',
  'extract-python-sources',
  'build-python',
  'install-python',
  'setup-python-packages',
  'patch-python-interpreter',
  'prepare-python-executables-packages',
  'create-python-symlinks'
));
