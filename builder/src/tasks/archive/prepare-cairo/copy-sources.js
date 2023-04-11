const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'cairo.srcCache');
const localRepo = get(config, 'cairo.localRepo');
const fs = require('fs-extra');

gulp.task('copy-cairo-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
