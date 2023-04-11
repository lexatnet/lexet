const gulp = require('gulp');
require('./get-xkbcommon-sources');
require('./copy-xkbcommon-sources');
require('./configure-xkbcommon');
require('./build-xkbcommon');
require('./install-xkbcommon');

gulp.task('prepare-xkbcommon', gulp.series(
  'get-xkbcommon-sources',
  'copy-xkbcommon-sources',
  'configure-xkbcommon',
  'build-xkbcommon',
  'install-xkbcommon',
));
