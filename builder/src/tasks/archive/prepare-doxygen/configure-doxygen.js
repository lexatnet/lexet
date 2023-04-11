const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const fs = require('fs-extra');
const config = require('@config');
const localRepo = get(config, 'doxygen.localRepo');
const buildDir = get(config, 'doxygen.buildDir');

gulp.task('configure-doxygen', async () => {


  const build = `${localRepo}/${buildDir}`;
  await fs.ensureDir(build);

  const env = {
    // 'EXTENSION_DIR': extDest
  };

  await pipeOutput(execa(
    'cmake',
    [
      '-G "Unix Makefiles" ..',
    ],
    {
      cwd: build,
      shell: true,
      env,
    }
  ));
});
