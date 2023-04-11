const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'pixman.srcCache');
const localRepo = get(config, 'pixman.localRepo');
const fs = require('fs-extra');

gulp.task('copy-pixman-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
