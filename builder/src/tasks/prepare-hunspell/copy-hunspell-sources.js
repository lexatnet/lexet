const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput, ensureDir } = require('@lib');
const config = require('@config');
const srcCache = get(config, 'hunspell.srcCache');
const localRepo = get(config, 'hunspell.localRepo');

gulp.task('copy-hunspell-sources', async () => {

  const dest = `${localRepo}/..`;
  await ensureDir(dest);
  await pipeOutput(execa(
    'cp',
    [
      '-r',
      srcCache,
      dest
    ]
  ));
});
