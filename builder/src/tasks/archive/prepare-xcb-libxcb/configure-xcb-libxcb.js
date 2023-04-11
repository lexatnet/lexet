const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const fs = require('fs-extra');
const config = require('@config');
const localRepo = get(config, 'xcbLibxcb.localRepo');
const buildDir = get(config, 'xcbLibxcb.buildDir');
const dest = get(config, 'xcbLibxcb.dest');
const xcbprotoDest = get(config, 'xcbproto.dest');


gulp.task('configure-xcb-libxcb', gulp.series(
  async () => {
    await pipeOutput(execa.command(
      [
        'autoreconf',
        '--install'
      ].join(' '),
      { cwd: localRepo }
    ));
  },
  async () => {
    const build = `${localRepo}/${buildDir}`;
    await fs.ensureDir(build);

    const env = {
      // CFLAGS:'${CFLAGS:--O2 -g} -Wno-error=format-extra-args',
      // CFLAGS:'-Wno-error=format-extra-args',
      PYTHON:'python3',
      // 'PKG_CONFIG_PATH': `${xcbprotoDest}/usr/local/lib/pkgconfig`,
      'PKG_CONFIG_PATH': `${xcbprotoDest}/lib/pkgconfig`,
      // 'XCBPROTO_XCBINCLUDEDIR': `${xcbprotoDest}/usr/local/share/xcb`,
      // 'XCBPROTO_XCBINCLUDEDIR': `${xcbprotoDest}/usr/local/share/xcb`,
      // 'XCBPROTO_XCBPYTHONDIR': `${xcbprotoDest}/usr/local/lib/python3.8/site-packages`,
      // XORG_CONFIG:process.env.XORG_CONFIG,
    };

    await pipeOutput(execa(
      './configure',
      [
        `--prefix ${dest}`,
        '--without-doxygen',
        // '--docdir=${datadir}/doc/libxcb-1.14',
        ],
      {
        cwd: localRepo,
        shell: true,
        env,
      }
    ));
  }
));
