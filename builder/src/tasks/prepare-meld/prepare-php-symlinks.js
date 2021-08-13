const gulp = require('gulp');
const { get } = require('lodash');
const { ensureRelativeSymlink, mapSeries} = require('@lib');

const config = require('@config');
const binDest = get(config, 'php.binDest');
const appDir = get(config, 'appDir');


const bins = [
  'php',
  'phar',
  'composer',
  'phpcs',
  'phpcbf',
];

const preparePHPBinSymlink = async (bin) => {
  try {
    const binPath = `${binDest}/bin/${bin}`;
    const linkPath = `${appDir}/bin/${bin}`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
};

gulp.task('prepare-php-symlinks', async () => {
  await mapSeries(bins, preparePHPBinSymlink);
});
