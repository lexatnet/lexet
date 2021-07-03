const execa = require('execa');
const gulp = require('gulp');
const { ensureDir, pipeOutput } = require('@lib');
const { stat }  = require('fs/promises');
const { get } = require('lodash');
const config = require('@config');
const cachePath = get(config, 'hunspell.cachePath');
const srcCache = get(config, 'hunspell.srcCache');
const srcUrl = get(config, 'hunspell.srcUrl');

gulp.task('get-hunspell-sources', async () => {

  let shouldDownloadSources = false;
  try {
    await stat(srcCache);
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant find hunspell sources in cache');
    shouldDownloadSources = true;
  }

  if (shouldDownloadSources) {
    await ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log('downloading hunspell sources');
    await pipeOutput(execa(
      'git',
      [
        'clone',
        '--depth 1',
        '--',
        srcUrl,
        srcCache,
      ],
      {
        shell: true
      }
    ));
  }
});
