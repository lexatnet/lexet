const gulp = require('gulp');
require('./get-php-sources');
require('./copy-php-sources');
require('./buildconf-php');
require('./configure-php');
require('./make-php');
require('./install-php');
// require('./prepare-php-packages');
require('./patch-php-interpreter');
require('./prepare-php-symlinks');

gulp.task('prepare-php', gulp.series(
  'get-php-sources',
  'copy-php-sources',
  'buildconf-php',
  'configure-php',
  'make-php',
  'install-php',
  // 'prepare-php-packages',
  'patch-php-interpreter',
  'prepare-php-symlinks',
));
