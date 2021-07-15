const gulp = require('gulp');
require('./get-atom-bins');
require('./extract-atom-bins');
require('./prepare-atom-packages');
require('./prepare-atom-config');

gulp.task('prepare-atom', gulp.series(
  'get-atom-bins',
  'extract-atom-bins',
  'prepare-atom-packages',
  'prepare-atom-config'
));
