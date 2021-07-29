const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'php.localRepo');
const libDest = get(config, 'php.libDest');
const binDest = get(config, 'php.binDest');

gulp.task('configure-php', async () => {
  await pipeOutput(execa(
    './configure',
    [
      '--enable-debug',
      `--prefix=${libDest}`,
      `--exec-prefix=${binDest}`,
      // `--sysconfdir=$sysconfdir`,
    ],
    {
      cwd: localRepo,
      shell: true,
    }
  ));
});
