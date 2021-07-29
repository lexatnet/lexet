const execa = require('execa');
const gulp = require('gulp');
const { get } = require('lodash');
const { pipeOutput, mapSeries, ensureDir } = require('@lib');
const fs = require('fs-extra')


const config = require('@config');
const destination = get(config, 'atom.dest');
const atomHomeTemplate = get(config, 'atom.atomHomeTemplate');
const atomHomeCache = get(config, 'atom.atomHomeCache');
const packages = get(config, 'atom.packages');


const installPackage = async (package) => {
  await ensureDir(atomHomeCache);
  await pipeOutput(execa(
    'apm',
    [
      'install',
      package
    ],{
      env: {
        'PATH': `${destination}/resources/app/apm/bin:${process.env['PATH']}`,
        'ATOM_HOME': atomHomeCache,
      },
      shell: 'bash'
    }
  ));
};

gulp.task('prepare-atom-packages-cache', async () => {
  await mapSeries(packages, installPackage);
});


gulp.task('prepare-atom-packages-template', async () => {
  await fs.copy(`${atomHomeCache}/packages`, `${atomHomeTemplate}/packages`);
});


gulp.task('prepare-atom-packages', gulp.series(
  'prepare-atom-packages-cache',
  'prepare-atom-packages-template'
));
