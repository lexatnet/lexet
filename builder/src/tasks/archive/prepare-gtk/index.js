const gulp = require('gulp');
require('./get-sources');
require('./copy-sources');
require('./configure');
require('./build');
require('./install');

gulp.task('prepare-gtk', gulp.series(
  'get-gtk-sources',
  'copy-gtk-sources',
  'configure-gtk',
  'build-gtk',
  'install-gtk',
));
