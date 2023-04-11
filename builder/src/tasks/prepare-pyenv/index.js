const gulp = require('gulp');
require('./get-pyenv-sources');
require('./copy-pyenv-sources');
require('./copy-python-versions');

gulp.task('prepare-pyenv', gulp.series(
  'get-pyenv-sources',
  'copy-pyenv-sources',
));
