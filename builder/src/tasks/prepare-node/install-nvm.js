const gulp = require('gulp');
const execa = require('execa');
const { get } = require('lodash');
const { pipeOutput } = require('@lib');
const config = require('@config');
const nvmRoot = get(config, 'nvm.root');

gulp.task('install-nvm', async () => {
  await pipeOutput(execa.command(
    [
      `[ -d ${nvmRoot} ]`,
      `git clone https://github.com/nvm-sh/nvm.git ${nvmRoot}`
    ].join(' || '),
    {
      shell: '/bin/bash',
    }
  ));

  const {
      stdout: commits
  } =  await execa.command(
      [
          'git',
          'rev-list',
          '--tags',
          '--max-count=1',

      ].join(' '),
      { cwd: nvmRoot }
  );

  const { stdout: tag } =  await execa.command(
      [
          'git',
          'describe',
          '--abbrev=0',
          '--tags',
          '--match "v[0-9]*"',
           commits

      ].join(' '),
      {
        shell: '/bin/bash',
        cwd: nvmRoot
      }
  );

  await pipeOutput(execa.command(
    [
        'git',
        'checkout',
        tag
    ].join(' '),
    {
      shell: '/bin/bash',
      cwd: nvmRoot
    }
  ));
});
