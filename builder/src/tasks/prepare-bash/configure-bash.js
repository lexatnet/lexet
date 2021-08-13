const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'bash.localRepo');
const destination = get(config, 'bash.destination');

gulp.task('configure-bash', async () => {
  await pipeOutput(execa.command(
    [
      './configure',
      `--prefix ${destination}`
    ].join(' '),
    { cwd: localRepo }
  ));
});
