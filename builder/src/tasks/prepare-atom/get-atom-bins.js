const execa = require('execa');
const gulp = require('gulp');
const { get } = require('lodash');
const { stat }  = require('fs/promises');

const { ensureDir, pipeOutput } = require('@lib');

const config = require('@config');
const binUrl = get(config, 'atom.binUrl');
const binCache = get(config, 'atom.binCache');
const binsPath = get(config, 'atom.binsPath');



gulp.task('get-atom-bins', async () => {
  let shouldDownloadBins = false;
  try {
    await stat(binsPath);
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant find atom bins in cache');
    shouldDownloadBins = true;
  }

  if (shouldDownloadBins) {
    await ensureDir(binCache);
    // eslint-disable-next-line no-console
    console.log('downloading atom bins');
    await pipeOutput(execa(
      'wget',
      [
        `--directory-prefix=${binCache}`,
        `--output-document=${binsPath}`,
          binUrl,
      ]
    ));
  }
});
