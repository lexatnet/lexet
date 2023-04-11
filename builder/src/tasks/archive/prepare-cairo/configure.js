const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'cairo.localRepo');
const dest = get(config, 'cairo.dest');
// const pixmanDest = get(config, 'pixman.dest');
const xcbLibxcb = get(config, 'pixman.dest');


gulp.task('configure-cairo', gulp.series(
  async () => {
    // await pipeOutput(execa.command(
    //   [
    //     'autoreconf',
    //     '--install'
    //   ].join(' '),
    //   { cwd: localRepo }
    // ));
  },
  async () => {
    const env = {
      'PKG_CONFIG_PATH': [
        // `${pixmanDest}/lib/pkgconfig`,
        `${xcbLibxcb}/lib/pkgconfig`,
      ],
      // LD_LIBRARY_PATH: [
      //   `${xcbLibxcb}/lib`,
      // ]
    };
    await pipeOutput(execa(
      './configure',
      [
        `--prefix=${dest}`,
        // '--enable-xcb',
        // '--enable-xlib-xcb',
      ],
      {
        cwd: localRepo,
        shell: true,
        env,
      }
    ));
  }
));
