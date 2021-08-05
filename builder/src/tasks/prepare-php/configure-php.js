const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const fs = require('fs-extra');
const config = require('@config');
const localRepo = get(config, 'php.localRepo');
const libDest = get(config, 'php.libDest');
const binDest = get(config, 'php.binDest');
const extDest = get(config, 'php.extDir');

gulp.task('configure-php', async () => {

  await fs.ensureDir(extDest);

  const env = {
    'EXTENSION_DIR': extDest
  };

  await pipeOutput(execa(
    './configure',
    [
      '--enable-debug',
      `--prefix=${libDest}`,
      `--exec-prefix=${binDest}`,
      '--with-readline',
      // '--with-phar',
      // '--with-xmlwriter',
      // '--with-json',
      // '--with-tokenizer',
      // '--with-simplexml',
      // '--with-iconv',
      // '--with-mbstring',
      // `--sysconfdir=$sysconfdir`,
    ],
    {
      cwd: localRepo,
      shell: true,
      env,
    }
  ));
});
