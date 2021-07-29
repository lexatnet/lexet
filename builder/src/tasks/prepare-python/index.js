const gulp = require('gulp');
require('./get-python-sources');
require('./extract-python-sources');
require('./configure-python');
require('./make-python');
require('./install-python');
require('./prepare-python-packages');
require('./patch-python-interpreter');
require('./prepare-python-executables-packages');
require('./prepare-python-symlinks');
require('./prepare-virtual-environment');


gulp.task('prepare-python', gulp.series(
  'get-python-sources',
  'extract-python-sources',
  'configure-python',
  'make-python',
  'install-python',
  'prepare-python-packages',
  'patch-python-interpreter',
  'prepare-python-executables-packages',
  'prepare-python-symlinks',
  // 'prepare-virtual-environment'
));
