const execa = require('execa');
const gulp = require('gulp');
const { get } = require('lodash');
const { stat }  = require('fs/promises');

const { ensureDir, pipeOutput } = require('@lib');

const config = require('@config');
const binUrl = get(config, 'atom.binUrl');
const binZip = get(config, 'atom.binZip');
const binCache = get(config, 'atom.binCache');
const destination = get(config, 'atom.dest');

const binsPath = `${binCache}/${binZip}`;

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


gulp.task('extract-atom-bins', async () => {
  await ensureDir(destination);
  await pipeOutput(execa(
    'tar',
    [
      '--extract',
      '--verbose',
      '--gzip',
      `--directory=${destination}`,
      `--file=${binsPath}`,
      '--strip-components=1',
    ]
  ));
});

gulp.task('prepare-atom', gulp.series(
  'get-atom-bins',
  'extract-atom-bins'
));
