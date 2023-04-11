const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'xcbproto.srcCache');
const localRepo = get(config, 'xcbproto.localRepo');
const fs = require('fs-extra');

gulp.task('copy-xcbproto-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
