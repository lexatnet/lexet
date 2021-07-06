const gulp = require('gulp');
const del = require('del');
const { get } = require('lodash');
const config = require('@config');
const buildRoot = get(config, 'buildRoot');

gulp.task('clean-staff', async () => {
  await del([
    `${buildRoot}/workspace/*`,
    `${buildRoot}/.cache/*`,
    // '/home/*',
    // '/env/nvm/alias/*',
    // '/env/nvm/versions/*',
    // '/env/nvm/.cache/*',
  ],{
      force: true
  });
});

gulp.task('clean', gulp.series(
  'clean-staff'
));
