const gulp = require('gulp');
require('./get-meld-sources');
require('./copy-meld-sources');
require('./meson-meld');
require('./ninja-meld');
require('./install-meld');
// require('./patch-php-interpreter');
// require('./prepare-php-symlinks');

gulp.task('prepare-meld', gulp.series(
  'get-meld-sources',
  'copy-meld-sources',
  'meson-meld',
  'ninja-meld',
  'install-meld',
  // 'patch-php-interpreter',
  // 'prepare-php-symlinks',
));
