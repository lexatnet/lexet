const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'meld.srcCache');
const localRepo = get(config, 'meld.localRepo');
const fs = require('fs-extra');

gulp.task('copy-meld-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
