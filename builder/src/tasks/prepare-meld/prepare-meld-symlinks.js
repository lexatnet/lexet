const gulp = require('gulp');
const { get } = require('lodash');
const { ensureRelativeSymlink, mapSeries} = require('@lib');

const config = require('@config');
const localRepo = get(config, 'meld.localRepo');
const appDir = get(config, 'appDir');


const bins = [
  'meld',
];

const prepareMeldBinSymlink = async (bin) => {
  try {
    const binPath = `${localRepo}/bin/${bin}`;
    const linkPath = `${appDir}/bin/${bin}`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
};

gulp.task('prepare-meld-symlinks', async () => {
  await mapSeries(bins, prepareMeldBinSymlink);
});
