const gulp = require('gulp');
require('./get-glib-sources');
require('./copy-glib-sources');
require('./configure-glib');
require('./build-glib');
require('./install-glib');

gulp.task('prepare-glib', gulp.series(
  'get-glib-sources',
  'copy-glib-sources',
  'configure-glib',
  'build-glib',
  'install-glib',
));
