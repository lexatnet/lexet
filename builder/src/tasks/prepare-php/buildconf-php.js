const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'php.localRepo');

gulp.task('buildconf-php', async () => {
  await pipeOutput(execa(
    './buildconf',[],
    { cwd: localRepo }
  ));
});
