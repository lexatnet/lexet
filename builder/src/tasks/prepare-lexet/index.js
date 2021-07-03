const gulp = require('gulp');
require('./copy-lexet');
require('./prepare-icon');
require('./prepare-apprun');
require('./prepare-desktop');

gulp.task('prepare-lexet', gulp.series(
  'copy-lexet',
  'prepare-icon',
  'prepare-apprun',
  'prepare-desktop',
));
