const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'meld.localRepo');
const buildDir = get(config, 'meld.buildDir');
const dest = get(config, 'meld.dest');


gulp.task('meson-meld', async () => {
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
