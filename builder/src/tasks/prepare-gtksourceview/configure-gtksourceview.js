const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'gtksourceview.localRepo');
const buildDir = get(config, 'gtksourceview.buildDir');
const dest = get(config, 'gtksourceview.dest');


gulp.task('configure-gtksourceview', async () => {

  // const env = {
  //   'PYTHONPATH': pythonPath,
  //   'INCLUDE': `${destination}/bin/include/pyhton3.9`
  // };

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
