const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'gtk.localRepo');
const buildDir = get(config, 'gtk.buildDir');
const dest = get(config, 'gtk.dest');
const xkbcommonDest = get(config, 'xkbcommon.dest');


gulp.task('configure-gtk', async () => {

  const env = {
    'PKG_CONFIG_PATH': `${xkbcommonDest}/lib/x86_64-linux-gnu/pkgconfig`,
  };

  await pipeOutput(execa(
    'meson',[
      buildDir,
      `--prefix ${dest}`
    ],
    {
      cwd: localRepo,
      shell: true,
      env,
    }
  ));
});
