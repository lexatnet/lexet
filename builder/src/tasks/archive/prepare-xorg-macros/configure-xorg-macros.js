const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const fs = require('fs-extra');
const config = require('@config');
const localRepo = get(config, 'xcbLibxcb.localRepo');
const buildDir = get(config, 'xcbLibxcb.buildDir');


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
      CFLAGS:'-Wno-error=format-extra-args',
      PYTHON:'python3',
      XORG_CONFIG:process.env.XORG_CONFIG,
    };

    await pipeOutput(execa(
      './configure',
      [
        '--without-doxygen',
        '--docdir=${datadir}/doc/libxcb-1.14',
        ],
      {
        cwd: build,
        shell: true,
        env,
      }
    ));
  }
));
