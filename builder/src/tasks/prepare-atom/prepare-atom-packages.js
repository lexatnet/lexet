const execa = require('execa');
const gulp = require('gulp');
const { get } = require('lodash');
const { pipeOutput, mapSeries, ensureDir } = require('@lib');


const config = require('@config');
const destination = get(config, 'atom.dest');
const atomHome = get(config, 'atom.atomHome');
const packages = get(config, 'atom.packages');


const installPackage = async (package) =>{
  await ensureDir(atomHome);
  await pipeOutput(execa(
    'apm',
    [
      'install',
      package
    ],{
      env: {
        'PATH': `${destination}/resources/app/apm/bin:${process.env['PATH']}`,
        'ATOM_HOME': atomHome,
      },
      shell: 'bash'
    }
  ));
};

gulp.task('prepare-atom-packages', async () => {
  await mapSeries(packages, installPackage);
});
