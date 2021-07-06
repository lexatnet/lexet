const gulp = require('gulp');
const { get } = require('lodash');
const { writeFile }  = require('fs/promises');
const config = require('@config');
const desktopDest = get(config, 'lexet.desktopDest');



gulp.task('prepare-desktop', async () => {

  const content = [
    '[Desktop Entry]',
    'Type=Application',
    'Name=Lexet',
    'Comment=IDE',
    'Icon=lexet',
    'Exec=emacs %F',
    'Terminal=false',
    'Categories=Development;',
    'Keywords=Editor;',
    'MimeType=text/x-python3;',
  ].join('\n');

  try {
    await writeFile(desktopDest, content);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});
