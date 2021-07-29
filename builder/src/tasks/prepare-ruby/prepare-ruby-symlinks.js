const gulp = require('gulp');
const { get } = require('lodash');
const fs = require('fs-extra');
const { ensureRelativeSymlink } = require('@lib');

const config = require('@config');
const binDest = get(config, 'ruby.binDest');
const appDir = get(config, 'appDir');


gulp.task('prepare-ruby-symlink', async () => {
  try {
    const binPath = `${binDest}/bin/ruby`;
    const linkPath = `${appDir}/bin/ruby`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});

gulp.task('prepare-rubocop-symlink', async () => {
  try {
    const binPath = `${binDest}/bin/ruby`;
    const linkPath = `${appDir}/bin/ruby`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});

gulp.task('prepare-ruby-symlinks', gulp.series(
  'prepare-ruby-symlink'
));
