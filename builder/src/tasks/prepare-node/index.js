const gulp = require('gulp');
require('./install-nvm');
require('./create-nvm-init-script');
require('./create-default-packages-file');
require('./install-node');

gulp.task('prepare-node', gulp.series(
  'install-nvm',
  'create-nvm-init-script',
  'create-default-packages-file',
  'install-node'
));
