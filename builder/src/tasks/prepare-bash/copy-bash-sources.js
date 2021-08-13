const gulp = require('gulp');
const { get } = require('lodash');
const fs = require('fs-extra');
const config = require('@config');
const srcCache = get(config, 'bash.srcCache');
const localRepo = get(config, 'bash.localRepo');

gulp.task('copy-bash-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
