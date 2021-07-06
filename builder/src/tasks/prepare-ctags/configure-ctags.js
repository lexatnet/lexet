const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'ctags.localRepo');
const destination = get(config, 'ctags.destination');

gulp.task('configure-ctags', async () => {
  await pipeOutput(execa.command(
    [
      './configure',
      `--prefix ${destination}`
    ].join(' '),
    { cwd: localRepo }
  ));
});
