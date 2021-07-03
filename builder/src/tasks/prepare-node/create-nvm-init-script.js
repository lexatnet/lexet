const gulp = require('gulp');
const { get } = require('lodash');
const config = require('@config');
const { writeFile }  = require('fs/promises');
const nvmInitScriptPath = get(config, 'nvm.init');
const appimageNvmRoot  = get(config, 'nvm.appimageNvmRoot');

gulp.task('create-nvm-init-script', async () => {
  const nvmInitScript = [
    `export NVM_DIR=${appimageNvmRoot}`,
    `[ -s "${appimageNvmRoot}/nvm.sh" ] && . "${appimageNvmRoot}/nvm.sh"`,
    `[ -s "${appimageNvmRoot}/bash_completion" ] && . "${appimageNvmRoot}/bash_completion"  # This loads nvm bash_completion`
  ].join('\n');
  try {
    await writeFile(nvmInitScriptPath, nvmInitScript);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});
