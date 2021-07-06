const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const destination = get(config, 'python3.destination');
const executable = get(config, 'python3.executable');
const pythonPath = get(config, 'python3.pythonPath');

gulp.task('setup-python-packages', async () => {
  try {

    const packages = `${destination}/packages`;
    await ensureDir(packages);

    const env = {
      'PYTHONPATH': pythonPath,
      'INCLUDE': `${destination}/bin/include/pyhton3.9`
    };

    await pipeOutput(execa(
      executable,
      [
        '-m pip',
        'install',
        `--target ${packages}`,
        'pylint',
      ]
      ,
      {
        shell: true,
        env,
        cwd: packages
      }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant install', e);
  }
});
