const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'gtksourceview.localRepo');
const buildDir = get(config, 'gtksourceview.buildDir');
const dest = get(config, 'gtksourceview.dest');
const glibDest = get(config, 'glib.dest');


gulp.task('configure-gtksourceview', async () => {



  const env = {
    // 'CMAKE_PREFIX_PATH': `${glibDest}/lib/x86_64-linux-gnu`,
    // 'CMAKE_LIBRARY_PATH': `${glibDest}/lib/x86_64-linux-gnu`,
    // 'CMAKE_SYSTEM_LIBRARY_PATH': `${glibDest}/lib/x86_64-linux-gnu`,
    'PKG_CONFIG_PATH': `${glibDest}/lib/x86_64-linux-gnu/pkgconfig`,
    // 'INCLUDE': `${destination}/bin/include/pyhton3.9`
  };

  await pipeOutput(execa(
    'meson',[
      buildDir,
      `--prefix ${dest}`,
      // `--add-library-search-path=`,
    ],
    // 'echo',[
    //   '$LIBRARY_PATH'
    // ],
    {
      cwd: localRepo,
      shell: true,
      env,
    }
  ));
});
