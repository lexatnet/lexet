const gulp = require('gulp');
require('./get-atom-bins');
require('./extract-atom-bins');

gulp.task('prepare-atom', gulp.series(
  'get-atom-bins',
  'extract-atom-bins'
));
