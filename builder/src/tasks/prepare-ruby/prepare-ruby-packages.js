const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput, mapSeries } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const binDest = get(config, 'ruby.binDest');
const packages = get(config, 'ruby.packages');


const installRubyPackage = async (package) => {
  const gem = `${binDest}/bin/gem`;

  await pipeOutput(execa(
    gem,
    [
      'install',
      package,
    ],
    {
      shell: true,
    }
  ));
};

gulp.task('prepare-ruby-packages', async () => {
  await mapSeries(packages, installRubyPackage);
});
