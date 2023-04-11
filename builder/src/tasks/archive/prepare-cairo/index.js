const gulp = require('gulp');
require('./get-sources');
require('./copy-sources');
require('./configure');
require('./build');
require('./install');

gulp.task('prepare-cairo', gulp.series(
  'get-cairo-sources',
  'copy-cairo-sources',
  'configure-cairo',
  'build-cairo',
  'install-cairo',
));
