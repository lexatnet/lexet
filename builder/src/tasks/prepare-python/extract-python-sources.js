const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'python3.localRepo');
const pythonSrc =  get(config, 'python3.pythonSrc');

gulp.task('extract-python-sources', async () => {
  await ensureDir(localRepo);
  await pipeOutput(execa(
    'tar',
    [
      '--extract',
      '--verbose',
      '--gzip',
      `--directory=${localRepo}`,
      `--file=${pythonSrc}`,
      '--strip-components=1',
    ]
    // ,
    // { cwd: localRepo }
  ));
});
