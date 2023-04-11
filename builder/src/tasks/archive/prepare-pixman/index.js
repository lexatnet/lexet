const gulp = require('gulp');
require('./get-sources');
require('./copy-sources');
require('./configure');
require('./build');
require('./install');

gulp.task('prepare-pixman', gulp.series(
  'get-pixman-sources',
  'copy-pixman-sources',
  'configure-pixman',
  'build-pixman',
  'install-pixman',
));
