const execa = require('execa');
const gulp = require('gulp');
const fs = require('fs-extra');

const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const cachePath = get(config, 'pixman.cachePath');
const srcCache = get(config, 'pixman.srcCache');
const srcUrl = get(config, 'pixman.srcUrl');
const branch = get(config, 'pixman.branch');

gulp.task('get-pixman-sources', async () => {

  let shouldDownloadSources = !(await fs.pathExists(srcCache));

  if (shouldDownloadSources) {
    await ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log('downloading pixman sources');
    await pipeOutput(execa(
      'git',
      [
        'clone',
        '--depth 1',
        branch,
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
