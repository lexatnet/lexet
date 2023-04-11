const execa = require('execa');
const gulp = require('gulp');
const fs = require('fs-extra');

const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const cachePath = get(config, 'cairo.cachePath');
const srcCache = get(config, 'cairo.srcCache');
const srcUrl = get(config, 'cairo.srcUrl');

gulp.task('get-cairo-sources', async () => {

  let shouldDownloadSources = !(await fs.pathExists(srcCache));

  if (shouldDownloadSources) {
    await ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log('downloading cairo sources');
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
