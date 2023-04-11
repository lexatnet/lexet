const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'xcbLibxcb.localRepo');
const buildDir = get(config, 'xcbLibxcb.buildDir');
const dest = get(config, 'xcbLibxcb.dest');

gulp.task('install-xcb-libxcb', async () => {

  const build = `${localRepo}/${buildDir}`;

  try {
    await ensureDir(dest);
    await pipeOutput(execa(
      'make',
      [
        // `DESTDIR=${dest}`,
        'install',
      ],
      {
        // cwd: build
        cwd: localRepo
       }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
