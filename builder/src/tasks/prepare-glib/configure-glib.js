const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'glib.localRepo');
const buildDir = get(config, 'glib.buildDir');
const dest = get(config, 'glib.dest');


gulp.task('configure-glib', async () => {
  await pipeOutput(execa(
    'meson',[
      buildDir,
      `--prefix ${dest}`
    ],
    {
      cwd: localRepo,
      shell: true,
    }
  ));
});
