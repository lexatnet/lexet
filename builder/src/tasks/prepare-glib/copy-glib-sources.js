const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'glib.srcCache');
const localRepo = get(config, 'glib.localRepo');
const fs = require('fs-extra');

gulp.task('copy-glib-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
