const gulp = require('gulp');
require('./get-xcb-libxcb-sources');
require('./copy-xcb-libxcb-sources');
require('./configure-xcb-libxcb');
require('./build-xcb-libxcb');
require('./install-xcb-libxcb');

gulp.task('prepare-xcb-libxcb', gulp.series(
  'get-xcb-libxcb-sources',
  'copy-xcb-libxcb-sources',
  'configure-xcb-libxcb',
  'build-xcb-libxcb',
  'install-xcb-libxcb',
));
