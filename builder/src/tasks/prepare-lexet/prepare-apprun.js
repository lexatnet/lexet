const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput } = require('@lib');
const config = require('@config');
const appRunScriptSrc = get(config, 'lexet.appRunScriptSrc');
const appRunScriptDest = get(config, 'lexet.appRunScriptDest');
const fs = require('fs-extra')

gulp.task('prepare-apprun', async () => {
  await fs.copy(appRunScriptSrc, appRunScriptDest);

  await pipeOutput(execa(
    'chmod',
    [
      '+x',
      appRunScriptDest
    ]
  ));
});
