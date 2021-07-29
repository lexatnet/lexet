const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'php.srcCache');
const localRepo = get(config, 'php.localRepo');
const fs = require('fs-extra');

gulp.task('copy-php-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
