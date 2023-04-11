const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'doxygen.localRepo');
const buildDir = get(config, 'doxygen.buildDir');
const dest = get(config, 'doxygen.dest');

gulp.task('install-doxygen', async () => {

  const build = `${localRepo}/${buildDir}`;

  try {
    await ensureDir(dest);
    await pipeOutput(execa(
      'make',
      [
        `DESTDIR=${dest}`,
        'install',
      ],
      { cwd: build }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
