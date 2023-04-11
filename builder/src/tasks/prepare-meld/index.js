const gulp = require('gulp');
require('./get-meld-sources');
require('./copy-meld-sources');
require('./prepare-meld-symlinks');

gulp.task('prepare-meld', gulp.series(
  'get-meld-sources',
  'copy-meld-sources',
  'prepare-meld-symlinks',
));
