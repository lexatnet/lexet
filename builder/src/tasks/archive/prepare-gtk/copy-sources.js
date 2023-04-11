const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const srcCache = get(config, 'gtk.srcCache');
const localRepo = get(config, 'gtk.localRepo');
const fs = require('fs-extra');

gulp.task('copy-gtk-sources', async () => {
  await fs.copy(srcCache, localRepo);
});
