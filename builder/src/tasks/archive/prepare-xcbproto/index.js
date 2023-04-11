const gulp = require('gulp');
require('./get-xcbproto-sources');
require('./copy-xcbproto-sources');
require('./configure-xcbproto');
require('./build-xcbproto');
require('./install-xcbproto');

gulp.task('prepare-xcbproto', gulp.series(
  'get-xcbproto-sources',
  'copy-xcbproto-sources',
  'configure-xcbproto',
  'build-xcbproto',
  'install-xcbproto',
));
