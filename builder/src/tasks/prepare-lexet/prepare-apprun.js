const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput } = require('@lib');
const config = require('@config');
const appRunScriptSrc = get(config, 'lexet.appRunScriptSrc');
const appRunScriptDest = get(config, 'lexet.appRunScriptDest');

gulp.task('prepare-apprun', async () => {
  await pipeOutput(execa(
    'cp',
    [
      '-r',
      appRunScriptSrc,
      appRunScriptDest
    ]
  ));

  await pipeOutput(execa(
    'chmod',
    [
      '+x',
      appRunScriptDest
    ]
  ));
});
