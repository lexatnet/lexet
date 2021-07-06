const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { stat }  = require('fs/promises');
const { get } = require('lodash');
const config = require('@config');
const localRepoCache = get(config, 'python3.localRepoCache');
const srcUrl = get(config, 'python3.srcUrl');
const pythonSrc =  get(config, 'python3.pythonSrc');

gulp.task('get-python-sources', async () => {

  let shouldDownloadSources = false;
  try {
    await stat(pythonSrc);
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant find python 3 sources in cache');
    shouldDownloadSources = true;
  }

  if (shouldDownloadSources) {
    await ensureDir(localRepoCache);
    // eslint-disable-next-line no-console
    console.log('downloading python 3 sources');
    await pipeOutput(execa(
      'wget',
      [
        `--directory-prefix=${localRepoCache}`,
        `--output-document=${pythonSrc}`,
          srcUrl,
      ]
    ));
  }
});
