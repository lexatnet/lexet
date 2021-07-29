const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'ruby.srcCache');
const localRepo = get(config, 'ruby.localRepo');
const fs = require('fs-extra');

gulp.task('copy-ruby-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
