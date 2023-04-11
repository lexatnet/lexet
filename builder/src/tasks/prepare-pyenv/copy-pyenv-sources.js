const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput, ensureDir } = require('@lib');
const config = require('@config');
const srcCache = get(config, 'pyenv.srcCache');
const destination = get(config, 'pyenv.destination');

gulp.task('copy-pyenv-sources', async () => {
  await ensureDir(destination);
  await pipeOutput(execa(
    'cp',
    [
      '-a',
      `${srcCache}/.`,
      destination
    ]
  ));
});
