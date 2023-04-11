const gulp = require('gulp');
require('./get-doxygen-sources');
require('./copy-doxygen-sources');
require('./configure-doxygen');
require('./build-doxygen');
require('./install-doxygen');

gulp.task('prepare-doxygen', gulp.series(
  'get-doxygen-sources',
  'copy-doxygen-sources',
  'configure-doxygen',
  'build-doxygen',
  'install-doxygen',
));
