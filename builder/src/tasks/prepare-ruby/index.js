const gulp = require('gulp');
require('./get-ruby-sources');
require('./copy-ruby-sources');
require('./autoreconf-ruby');
require('./configure-ruby');
require('./make-ruby');
require('./install-ruby');
require('./prepare-ruby-packages');
require('./patch-ruby-interpreter');
require('./prepare-ruby-symlinks');

gulp.task('prepare-ruby', gulp.series(
  'get-ruby-sources',
  'copy-ruby-sources',
  'autoreconf-ruby',
  'configure-ruby',
  'make-ruby',
  'install-ruby',
  'prepare-ruby-packages',
  'patch-ruby-interpreter',
  'prepare-ruby-symlinks',
));
