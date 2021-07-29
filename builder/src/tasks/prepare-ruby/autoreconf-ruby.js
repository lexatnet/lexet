const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'ruby.localRepo');

gulp.task('autoreconf-ruby', async () => {
  await pipeOutput(execa.command(
    [
      'autoreconf',
      '--install'
    ].join(' '),
    { cwd: localRepo }
  ));
});
