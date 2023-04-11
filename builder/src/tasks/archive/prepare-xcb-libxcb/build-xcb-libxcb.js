const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'xcbLibxcb.localRepo');
const xcbprotoDest = get(config, 'xcbproto.buildDir');

gulp.task('build-xcb-libxcb', async () => {
  try {
    const env = {
      // 'PKG_CONFIG_PATH': `${xcbprotoDest}/usr/local/lib/pkgconfig`,
      // 'XCBPROTO_XCBINCLUDEDIR':  `${xcbprotoDest}/usr/local/lib/pkgconfig`,
      // 'XCBPROTO_XCBPYTHONDIR':  `${xcbprotoDest}/usr/local/lib/python3.8`,
    };

    await pipeOutput(execa(
      'make',
      [
        '-j8'
      ],
      {
        // shell: true,
        cwd: localRepo,
        env
      }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant make', e);
  }
});
