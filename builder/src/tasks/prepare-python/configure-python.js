const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'python3.localRepo');
const destination = get(config, 'python3.destination');

gulp.task('configure-python', async () => {
  await pipeOutput(execa.command(
    [
      './configure',
      '--enable-optimizations',
      '--with-ensurepip=install',
      `--prefix ${destination}`
      // LDFLAGS="-L${libs}"
      // CFLAGS="${includes} -I${prefix}/includes/python3.9/iternal"
    ].join(' '),
    { cwd: localRepo }
  ));
});
