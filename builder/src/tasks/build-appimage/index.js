const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput } = require('@lib');
const config = require('@config');
const cwd = get(config, 'appimage.cwd');
const appDir = get(config, 'appimage.appDir');

gulp.task('build-appimage', async () => {
  try {
    await pipeOutput(execa(
      'appimagetool',
      [
        appDir,
      ],
      {
        shell: true,
        cwd,
        env: {
          'ARCH': 'x86_64'
        }
      }
    ));
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});
