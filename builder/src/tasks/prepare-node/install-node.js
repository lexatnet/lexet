const gulp = require('gulp');
const execa = require('execa');
const { get } = require('lodash');
const { pipeOutput } = require('@lib');
const config = require('@config');
const nvmRoot = get(config, 'nvm.root');

gulp.task('install-node', async () => {
  try {
    await pipeOutput(execa.command(
        [
          `NVM_DIR=${nvmRoot}`,
          `source ${nvmRoot}/nvm.sh --no-use`,
          'nvm ls-remote',
          'nvm install node'
        ].join(' && '),
        {
          // cwd: nvmRoot,
          shell: '/bin/bash',
          env: {
            NVM_DIR: nvmRoot
          }
        }
    ));
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});
