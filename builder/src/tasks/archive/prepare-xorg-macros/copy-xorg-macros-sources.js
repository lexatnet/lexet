const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'xcbLibxcb.srcCache');
const localRepo = get(config, 'xcbLibxcb.localRepo');
const fs = require('fs-extra');

gulp.task('copy-xcb-libxcb-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
