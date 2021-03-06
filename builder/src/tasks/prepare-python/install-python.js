const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'python3.localRepo');
const destination = get(config, 'python3.destination');

gulp.task('install-python', async () => {

  try {
    await ensureDir(destination);
    await pipeOutput(execa(
      'make',
      [
        'altinstall'
      ],
      { cwd: localRepo }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
