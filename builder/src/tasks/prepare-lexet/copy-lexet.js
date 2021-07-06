const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput } = require('@lib');
const config = require('@config');
const lexetSrc = get(config, 'lexet.src');
const lexetDest = get(config, 'lexet.dest');

gulp.task('copy-lexet', async () => {
  await pipeOutput(execa(
    'cp',
    [
      '-r',
      lexetSrc,
      lexetDest
    ]
  ));
});
