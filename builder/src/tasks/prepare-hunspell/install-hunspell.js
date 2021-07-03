const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'hunspell.localRepo');
const libDest = get(config, 'hunspell.libDest');
const binDest = get(config, 'hunspell.binDest');

gulp.task('install-hunspell', async () => {
  try {
    await ensureDir(libDest);
    await ensureDir(binDest);
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
