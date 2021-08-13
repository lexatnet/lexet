const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'glib.localRepo');
const buildDir = get(config, 'glib.buildDir');

gulp.task('build-glib', async () => {
  try {
    await pipeOutput(execa(
      'ninja',
      [
        '-j 8',
        // `-C ${localRepo}/${buildDir}`
      ],
      {
        shell: true,
        // cwd: localRepo
        cwd: `${localRepo}/${buildDir}`
      }
    ));
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log('cant make', e);
  }
});
