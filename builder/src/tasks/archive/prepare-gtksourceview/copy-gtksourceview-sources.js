const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'gtksourceview.srcCache');
const localRepo = get(config, 'gtksourceview.localRepo');
const fs = require('fs-extra');

gulp.task('copy-gtksourceview-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
