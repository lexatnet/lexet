const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'hunspell.localRepo');

gulp.task('autoreconf-hunspell', async () => {
  await pipeOutput(execa.command(
    [
      'autoreconf',
      '-vfi'
    ].join(' '),
    { cwd: localRepo }
  ));
});
