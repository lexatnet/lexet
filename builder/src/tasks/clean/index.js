const gulp = require('gulp');
const del = require('del');

const cleanBuild = async () => {
  await del([
    '/build/*'
  ],{
    force: true
  });
}

const cleanStaff = async () => {
  await del([
    '/builder/build/workspace/*',
    '/builder/build/.cache/*',
    // '/home/*',
    // '/env/nvm/alias/*',
    // '/env/nvm/versions/*',
    // '/env/nvm/.cache/*',
  ]);
}

exports.clean = gulp.series(
  cleanBuild,
  cleanStaff
)
