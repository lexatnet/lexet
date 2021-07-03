const gulp = require('gulp');
const del = require('del');
const { get } = require('lodash');

const config = require('@config');
const buildRoot = get(config, 'buildRoot');


const cleanStaff = async () => {
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
};

const clean = gulp.series(
  cleanStaff
);

gulp.task('clean', clean);
