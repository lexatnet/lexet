const gulp = require('gulp');
const { ensureDir, mapSeries } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const { pythonExec } = require('./lib');

const packages = get(config, 'python3.packages');
const packagesDest = get(config, 'python3.packagesDest');


const preparePythonPackage = async (package) => {
  try {

    await ensureDir(packagesDest);

    await pythonExec([
      '-m pip',
      'install',
      `--target ${packagesDest}`,
      package,
    ]);
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
};

gulp.task('prepare-python-packages', async () => {
  await mapSeries(packages, preparePythonPackage);
});
