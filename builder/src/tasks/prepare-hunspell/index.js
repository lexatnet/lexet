const gulp = require('gulp');
require('./get-hunspell-sources');
require('./copy-hunspell-sources');
require('./autoreconf-hunspell');
require('./configure-hunspell');
require('./make-hunspell');
require('./install-hunspell');
require('./ldconfig-hunspell');

gulp.task('prepare-hunspell', gulp.series(
  'get-hunspell-sources',
  'copy-hunspell-sources',
  'autoreconf-hunspell',
  'configure-hunspell',
  'make-hunspell',
  'install-hunspell',
  'ldconfig-hunspell'
));
