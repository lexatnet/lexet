const gulp = require('gulp');
require('./get-meld-sources');
require('./copy-meld-sources');
require('./configure-meld');
require('./build-meld');
require('./install-meld');
// require('./patch-php-interpreter');
// require('./prepare-php-symlinks');

gulp.task('prepare-meld', gulp.series(
  'get-meld-sources',
  'copy-meld-sources',
  'configure-meld',
  'build-meld',
  'install-meld',
  // 'patch-php-interpreter',
  // 'prepare-php-symlinks',
));
