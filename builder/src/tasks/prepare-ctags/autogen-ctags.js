const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'ctags.localRepo');

gulp.task('autogen-ctags', async () => {
  await pipeOutput(execa.command(
    [
      './autogen.sh'
    ].join(' '),
    { cwd: localRepo }
  ));
});
