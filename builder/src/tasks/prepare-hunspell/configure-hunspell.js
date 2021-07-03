const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'hunspell.localRepo');
const libDest = get(config, 'hunspell.libDest');
const binDest = get(config, 'hunspell.binDest');

gulp.task('configure-hunspell', async () => {
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
