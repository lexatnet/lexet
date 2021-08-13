const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'gtksourceview.localRepo');
const buildDir = get(config, 'gtksourceview.buildDir');

gulp.task('build-gtksourceview', async () => {
  try {
    await pipeOutput(execa(
      'ninja',
      [
        '-j 8'
      ],
      {
        // shell: true,
        cwd: `${localRepo}/${buildDir}`
      }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant make', e);
  }
});
