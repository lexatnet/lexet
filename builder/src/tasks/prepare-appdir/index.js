const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const { ensureDir, mapSeries, symlink } = require('@lib');
const appDir = get(config, 'appimageBuilder.appDir');

const dirTree = [
  `${appDir}/env`,
  `${appDir}/init`,
  `${appDir}/bin`,
  `${appDir}/lib`,
  `${appDir}/usr/share`
];

gulp.task('prepare-appdir-tree', async () => {
  await mapSeries(dirTree, ensureDir);
});

gulp.task('create-sh-symlink', async () => {
  try {
    await symlink( 'bash', `${appDir}/bin/sh`);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});

gulp.task('create-symlinks', gulp.series(
  'create-sh-symlink'
));

gulp.task('prepare-appdir', gulp.series(
  'prepare-appdir-tree',
  // 'prepare-apprun'
));
