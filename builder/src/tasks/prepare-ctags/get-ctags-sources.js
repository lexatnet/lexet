const execa = require('execa');
const gulp = require('gulp');
const fs = require('fs-extra');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const cachePath = get(config, 'ctags.cachePath');
const srcCache = get(config, 'ctags.srcCache');
const srcUrl = get(config, 'ctags.srcUrl');

gulp.task('get-ctags-sources', async () => {

  const shouldDownloadSources = !(await fs.pathExists(srcCache));

  if (shouldDownloadSources) {
    await ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log('downloading ctags sources');
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
