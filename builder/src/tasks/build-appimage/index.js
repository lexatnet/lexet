const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');
const { pipeOutput } = require('@lib');
const config = require('@config');
const cwd = get(config, 'appimageBuilder.cwd');
const appDir = get(config, 'appimageBuilder.appDir');
const recipe = get(config, 'appimageBuilder.recipe');

gulp.task('build-appimage-with-appimage-builder', async () => {
  try {
    await pipeOutput(execa(
      'appimage-builder',
      [
        `--recipe ${recipe}`,
        '--skip-test'
      ],
      {
        shell: true,
        cwd,
      }
    ));
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});


gulp.task('build-appimage-with-appimagetool', async () => {
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

gulp.task('build-appimage', gulp.series(
  'build-appimage-with-appimagetool'
));
