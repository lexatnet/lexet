const gulp = require('gulp');
const execa = require('execa');
const { get } = require('lodash');
const { ensureDir, pipeOutput } = require('@lib');

const config = require('@config');
const destination = get(config, 'atom.dest');
const binsPath = get(config, 'atom.binsPath');

gulp.task('extract-atom-bins', async () => {
  await ensureDir(destination);
  await pipeOutput(execa(
    'tar',
    [
      '--extract',
      '--verbose',
      '--gzip',
      `--directory=${destination}`,
      `--file=${binsPath}`,
      '--strip-components=1',
    ]
  ));
});
