const gulp = require('gulp');
const { symlink, ensureRelativeSymlink, mapSeries } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const destination = get(config, 'python3.destination');
const appDir = get(config, 'appDir');


const bins = [
  'python3',
  'python',
  'pip3',
  'pip',
];

const preparePythonBinSymlink = async (bin) => {
  try {
    const binPath = `${destination}/bin/${bin}`;
    const linkPath = `${appDir}/bin/${bin}`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
};

gulp.task('prepare-python-symlinks', async () => {
  try {
    await symlink('python3.9', `${destination}/bin/python3`);
    await symlink('python3.9', `${destination}/bin/python`);
    await symlink('pip3.9', `${destination}/bin/pip3`);
    await symlink('pip3.9', `${destination}/bin/pip`);
    await mapSeries(bins, preparePythonBinSymlink);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});
