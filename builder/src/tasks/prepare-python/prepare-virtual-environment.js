const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const venv = get(config, 'python3.venv');
const { pythonExec } = require('./lib');

gulp.task('prepare-virtual-environment', async () => {
  try {
    await pythonExec([
      '-m venv',
      '--copies',
      // '--prompt mmmm',
      venv
    ]);
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
