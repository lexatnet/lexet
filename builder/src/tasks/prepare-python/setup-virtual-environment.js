const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const executable = get(config, 'python3.executable');
const venv = get(config, 'python3.venv');
const pythonPath = get(config, 'python3.pythonPath');

gulp.task('setup-virtual-environment', async () => {
  try {
    await pipeOutput(execa(
      executable,
      [
        '-m venv',
        venv
      ]
      ,
      {
        shell: true,
        env: {
          'PYTHONPATH': pythonPath
        }
      }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
