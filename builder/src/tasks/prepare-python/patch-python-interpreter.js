const gulp = require('gulp');
const replace = require('replace-in-file');
const { get } = require('lodash');
const config = require('@config');
const destination = get(config, 'python3.destination');

gulp.task('patch-python-interpreter', async () => {
  try {

    const options = {
      files: [
        `${destination}/bin/*`,
        // `${venv}/bin/*`
      ],
      from: [
        /#!\/staff\/build\/workspace\/AppDir\/usr\/python3\/bin\/python3\.9/g,
        /#!\/staff\/build\/workspace\/AppDir\/venv\/bin\/python3/g
      ],
      to: '#!/usr/bin/env python3',
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
