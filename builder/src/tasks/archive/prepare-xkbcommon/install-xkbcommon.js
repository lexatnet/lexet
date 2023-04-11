const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'xkbcommon.localRepo');
const buildDir = get(config, 'xkbcommon.buildDir');
const dest = get(config, 'xkbcommon.dest');

gulp.task('install-xkbcommon', async () => {
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
