const gulp = require('gulp');
const { get } = require('lodash');

const config = require('@config');
const cwd = get(config, 'appimageBuilder.cwd');
const { spawn } = require('child_process');

// const { PassThrough } = require('stream');

// eslint-disable-next-line no-console
console.log('cwd=', cwd);

const ex1 = async () => {
  try {
    const options = {
      cwd,
      // cwd: '/builder/build',
      // env: process.env
    };

    // eslint-disable-next-line no-console
    console.log('options=', options);
    const child = spawn(
      'echo',
      [
        'hello'
      ],
      options
    );
    child.stdout.on('data', function(data) {
      // eslint-disable-next-line no-console
      console.log('log=',data.toString());
    });
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log('error',err);
  }
};

gulp.task('ex1', ex1);
