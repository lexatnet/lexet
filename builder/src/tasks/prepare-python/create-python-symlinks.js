const gulp = require('gulp');
const { symlink } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const destination = get(config, 'python3.destination');

gulp.task('create-python-symlinks', async () => {
  try {
    await symlink('python3.9', `${destination}/bin/python3`);
    await symlink('python3.9', `${destination}/bin/python`);
    await symlink('pip3.9', `${destination}/bin/pip3`);
    await symlink('pip3.9', `${destination}/bin/pip`);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});
