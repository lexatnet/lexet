const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'doxygen.localRepo');
const buildDir = get(config, 'doxygen.buildDir');

gulp.task('build-doxygen', async () => {
  try {
    const build = `${localRepo}/${buildDir}`;
    await pipeOutput(execa(
      'make',
      [
        '-j8'
      ],
      {
        // shell: true,
        cwd: build
      }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant make', e);
  }
});
