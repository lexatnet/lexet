const execa = require('execa');
const gulp = require('gulp');
const fs = require('fs-extra');

const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const cachePath = get(config, 'xcbLibxcb.cachePath');
const srcCache = get(config, 'xcbLibxcb.srcCache');
const srcUrl = get(config, 'xcbLibxcb.srcUrl');

gulp.task('get-xcb-libxcb-sources', async () => {

  let shouldDownloadSources = !(await fs.pathExists(srcCache));

  if (shouldDownloadSources) {
    await ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log('downloading xcb-libxcb sources');
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
