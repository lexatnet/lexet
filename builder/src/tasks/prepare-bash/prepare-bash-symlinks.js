const gulp = require('gulp');
const { get } = require('lodash');
const { ensureRelativeSymlink, mapSeries} = require('@lib');

const config = require('@config');
const destination = get(config, 'bash.destination');
const appDir = get(config, 'appDir');


const bins = [
  'bash',
  'bashbug',
];

const prepareBinSymlink = async (bin) => {
  try {
    const binPath = `${destination}/bin/${bin}`;
    const linkPath = `${appDir}/bin/${bin}`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
};

gulp.task('prepare-bash-symlinks', async () => {
  await mapSeries(bins, prepareBinSymlink);
});
