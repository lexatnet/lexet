const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'xkbcommon.srcCache');
const localRepo = get(config, 'xkbcommon.localRepo');
const fs = require('fs-extra');

gulp.task('copy-xkbcommon-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
