const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'bash.localRepo');
const destination = get(config, 'bash.destination');

gulp.task('install-bash', async () => {

  try {
    await ensureDir(destination);
    await pipeOutput(execa(
      'make',
      [
        'install'
      ],
      { cwd: localRepo }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
