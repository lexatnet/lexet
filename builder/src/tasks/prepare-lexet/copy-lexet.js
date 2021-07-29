const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput } = require('@lib');
const config = require('@config');
const lexetSrc = get(config, 'lexet.src');
const lexetDest = get(config, 'lexet.dest');
const fs = require('fs-extra')

gulp.task('copy-lexet', async () => {
  await fs.copy(lexetSrc, lexetDest);
});
