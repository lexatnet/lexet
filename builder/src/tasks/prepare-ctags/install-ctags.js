const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'ctags.localRepo');
const destination = get(config, 'ctags.destination');

gulp.task('install-ctags', async () => {

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
