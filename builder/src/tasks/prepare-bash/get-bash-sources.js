const execa = require('execa');
const gulp = require('gulp');
const fs = require('fs-extra');
const { ensureDir, pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const cachePath = get(config, 'bash.cachePath');
const srcCache = get(config, 'bash.srcCache');
const srcUrl = get(config, 'bash.srcUrl');

gulp.task('get-bash-sources', async () => {

  const shouldDownloadSources = !(await fs.pathExists(srcCache));

  if (shouldDownloadSources) {
    await ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log('downloading bash sources');
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
