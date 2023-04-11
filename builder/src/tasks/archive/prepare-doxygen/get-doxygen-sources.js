const execa = require('execa');
const gulp = require('gulp');
const fs = require('fs-extra');

const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const cachePath = get(config, 'doxygen.cachePath');
const srcCache = get(config, 'doxygen.srcCache');
const srcUrl = get(config, 'doxygen.srcUrl');

gulp.task('get-doxygen-sources', async () => {

  let shouldDownloadSources = !(await fs.pathExists(srcCache));

  if (shouldDownloadSources) {
    await ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log('downloading doxygen sources');
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
