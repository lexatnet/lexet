const gulp = require('gulp');
const replace = require('replace-in-file');
const { get } = require('lodash');
const config = require('@config');
const binDest = get(config, 'ruby.binDest');
// const libDest = get(config, 'ruby.libDest');

gulp.task('patch-ruby-interpreter', async () => {
  try {

    const options = {
      files: [
        `${binDest}/bin/*`,
        // `${venv}/bin/*`
      ],
      from: [
        /#!\/staff\/build\/workspace\/AppDir\/usr\/ruby\/bin\/bin\/ruby/g,
        // /#!\/staff\/build\/workspace\/AppDir\/venv\/bin\/python3/g
      ],
      to: '#!/usr/bin/env ruby',
      countMatches: true,
    };

    const results = await replace(options);
    // eslint-disable-next-line no-console
    console.log('Replacement results:', results);
  }
  catch (error) {
    // eslint-disable-next-line no-console
    console.error('Error occurred:', error);
  }
});
