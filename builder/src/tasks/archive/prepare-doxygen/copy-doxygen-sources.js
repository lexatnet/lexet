const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'doxygen.srcCache');
const localRepo = get(config, 'doxygen.localRepo');
const fs = require('fs-extra');

gulp.task('copy-doxygen-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
