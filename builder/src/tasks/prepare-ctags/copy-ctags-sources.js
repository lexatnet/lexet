const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput, ensureDir } = require('@lib');
const config = require('@config');
const srcCache = get(config, 'ctags.srcCache');
const localRepo = get(config, 'ctags.localRepo');

gulp.task('copy-ctags-sources', async () => {

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
