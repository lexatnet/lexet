const gulp = require('gulp');
require('./get-bash-sources');
require('./copy-bash-sources');
require('./configure-bash');
require('./make-bash');
require('./install-bash');
require('./prepare-bash-symlinks');

gulp.task('prepare-bash', gulp.series(
  'get-bash-sources',
  'copy-bash-sources',
  'configure-bash',
  'make-bash',
  'install-bash',
  'prepare-bash-symlinks',
));
