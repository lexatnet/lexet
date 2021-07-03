const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput } = require('@lib');
const config = require('@config');
const iconSrc = get(config, 'lexet.iconSrc');
const iconDest = get(config, 'lexet.iconDest');


gulp.task('prepare-icon', async () => {
  await pipeOutput(execa(
    'cp',
    [
      '-r',
      iconSrc,
      iconDest
    ]
  ));
});
