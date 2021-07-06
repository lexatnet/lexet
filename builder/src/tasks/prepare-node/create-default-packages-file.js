const gulp = require('gulp');
const { get } = require('lodash');
const { writeFile }  = require('fs/promises');
const config = require('@config');
const nvmRoot = get(config, 'nvm.root');
const defaultPackages =  get(config, 'nvm.defaultPackages');

gulp.task('create-default-packages-file', async () => {
  try {
    await writeFile(`${nvmRoot}/default-packages`, defaultPackages.join('\n'));
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});
