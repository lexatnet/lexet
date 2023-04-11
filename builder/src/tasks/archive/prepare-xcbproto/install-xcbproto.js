const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'xcbproto.localRepo');
const dest = get(config, 'xcbproto.dest');

gulp.task('install-xcbproto', async () => {
  try {
    await ensureDir(dest);
    await pipeOutput(execa(
      'make',
      [
        // `DESTDIR=${dest}`,
        'install',
      ],
      { cwd: localRepo }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
