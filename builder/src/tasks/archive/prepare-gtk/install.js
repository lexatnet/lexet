const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'gtk.localRepo');
const buildDir = get(config, 'gtk.buildDir');
const dest = get(config, 'gtk.dest');

gulp.task('install-gtk', async () => {
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
