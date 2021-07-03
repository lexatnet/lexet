const gulp = require('gulp');
require('./get-ctags-sources');
require('./copy-ctags-sources');
require('./autogen-ctags');
require('./configure-ctags');
require('./make-ctags');
require('./install-ctags');

gulp.task('prepare-ctags', gulp.series(
  'get-ctags-sources',
));
