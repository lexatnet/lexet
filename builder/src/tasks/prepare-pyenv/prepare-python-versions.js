const gulp = require('gulp');
const { ensureDir, mapSeries } = require('@lib');
const { get } = require('lodash');
const config = require('@config');

const versions = get(config, 'pyenv.versions');

const {pyenvExec} = require('./lib');

const preparePythonVersion = async (version) => {
  try {

    await pyenvExec([
      'install',
      version,
    ]);
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
};

gulp.task('prepare-python-packages', async () => {
  await mapSeries(versions, preparePythonVersion);
});
