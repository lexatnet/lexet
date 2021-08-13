const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'glib.localRepo');
const buildDir = get(config, 'glib.buildDir');
const dest = get(config, 'glib.dest');

gulp.task('install-glib', async () => {
  try {
    await ensureDir(dest);
    await pipeOutput(execa(
      'ninja',
      [
        'install'
      ],
      { cwd: `${localRepo}/${buildDir}` }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
