const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'python3.localRepo');

gulp.task('make-python', async () => {
  try {
    await pipeOutput(execa(
      'make',
      [
        '-j8'
      ],
      { cwd: localRepo }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant make', e);
  }
});
