const execa = require('execa');
const gulp = require('gulp');
const fs = require('fs-extra');

const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const cachePath = get(config, 'xkbcommon.cachePath');
const srcCache = get(config, 'xkbcommon.srcCache');
const srcUrl = get(config, 'xkbcommon.srcUrl');

gulp.task('get-xkbcommon-sources', async () => {

  let shouldDownloadSources = !(await fs.pathExists(srcCache));

  if (shouldDownloadSources) {
    await ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log('downloading xkbcommon sources');
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
