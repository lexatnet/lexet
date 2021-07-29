const gulp = require('gulp');
const { get } = require('lodash');
const fs = require('fs-extra');
const { ensureRelativeSymlink } = require('@lib');

const config = require('@config');
const destination = get(config, 'atom.dest');
const appDir = get(config, 'appDir');


gulp.task('prepare-apm-symlink', async () => {
  try {
    const binPath = `${destination}/resources/app/apm/bin/apm`;
    const linkPath = `${appDir}/bin/apm`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});

gulp.task('prepare-atom-symlink', async () => {
  try {
    const binPath = `${destination}/atom`;
    const linkPath = `${appDir}/bin/atom`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});

gulp.task('prepare-atom-symlinks', gulp.series(
  'prepare-apm-symlink',
  'prepare-atom-symlink'
));
