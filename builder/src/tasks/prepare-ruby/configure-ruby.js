const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'ruby.localRepo');
const libDest = get(config, 'ruby.libDest');
const binDest = get(config, 'ruby.binDest');

gulp.task('configure-ruby', async () => {
  await pipeOutput(execa.command(
    [
      './configure',
      `--prefix=${libDest}`,
      `--exec-prefix=${binDest}`,
      // `--sysconfdir=$sysconfdir`,
    ].join(' '),
    { cwd: localRepo }
  ));
});
