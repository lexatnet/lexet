const gulp = require('gulp');
const { get } = require('lodash');
const { ensureRelativeSymlink, mapSeries} = require('@lib');

const config = require('@config');
const binDest = get(config, 'ruby.binDest');
const appDir = get(config, 'appDir');


const bins = [
  'ruby',
  'rake',
  'gem',
  'bundler',
  'rubocop',
  'ruby-lint',
  'irb',
  'erb',
  'ri',
  'ruby-parse',
  'ruby-rewrite',
  'typeprof',
  'rdoc',
  'rbs',
  'racc',
];

const prepareRubyBinSymlink = async (bin) => {
  try {
    const binPath = `${binDest}/bin/${bin}`;
    const linkPath = `${appDir}/bin/${bin}`;
    await ensureRelativeSymlink(binPath, linkPath);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
};

gulp.task('prepare-ruby-symlinks', async () => {
  await mapSeries(bins, prepareRubyBinSymlink);
});
