const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput, mapSeries } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const binDest = get(config, 'ruby.binDest');
const rubyPath = get(config, 'ruby.rubyPath');
const packages = get(config, 'ruby.packages');


const installRubyPackage = async (package) => {
  const gem = `${binDest}/bin/gem`;

  // console.log(gem, package)
  // const env = {
  //   // 'PYTHONPATH': rubyPath,
  //   // 'INCLUDE': `${destination}/bin/include/pyhton3.9`
  // };

  await pipeOutput(execa(
    gem,
    [
      'install',
      package,
    ],
    {
      shell: true,
      // env,
      // cwd: packages
    }
  ));
};

gulp.task('prepare-ruby-packages', async () => {
  await mapSeries(packages, installRubyPackage);
});
