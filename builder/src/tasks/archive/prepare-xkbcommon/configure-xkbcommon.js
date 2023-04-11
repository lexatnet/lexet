const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'xkbcommon.localRepo');
const buildDir = get(config, 'xkbcommon.buildDir');
const dest = get(config, 'xkbcommon.dest');
const xcbLibxcbDest = get(config, 'xcbLibxcb.dest');


gulp.task('configure-xkbcommon', async () => {

  const env = {
    'PKG_CONFIG_PATH': `${xcbLibxcbDest}/lib/pkgconfig`,
  };

  await pipeOutput(execa(
    'meson',[
      buildDir,
      `--prefix ${dest}`,
      // '-Denable-x11=false',
      '-Denable-wayland=false',
      '-Denable-docs=false',
    ],
    {
      cwd: localRepo,
      shell: true,
      env,
    }
  ));
});
