const execa = require('execa');
const gulp = require('gulp');
const { get } = require('lodash');
const { pipeOutput, ensureDir } = require('@lib');


const config = require('@config');
const atomHome = get(config, 'atom.atomHome');
const configTemplateSrc = get(config, 'atom.configTemplateSrc');
const configTemplateDest = get(config, 'atom.configTemplateDest');

gulp.task('prepare-atom-config', async () => {
  await ensureDir(atomHome);
  await pipeOutput(execa(
    'cp',
    [
      '-r',
      configTemplateSrc,
      configTemplateDest
    ]
  ));
});
