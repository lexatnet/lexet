const gulp = require('gulp');
require('./get-gtksourceview-sources');
require('./copy-gtksourceview-sources');
require('./configure-gtksourceview');
require('./build-gtksourceview');
require('./install-gtksourceview');

gulp.task('prepare-gtksourceview', gulp.series(
  'get-gtksourceview-sources',
  'copy-gtksourceview-sources',
  'configure-gtksourceview',
  'build-gtksourceview',
  'install-gtksourceview',
));
