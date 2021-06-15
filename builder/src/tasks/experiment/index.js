const gulp = require('gulp');
const del = require('del');
const { get } = require('lodash');
const execa = require('execa');

const config = require('@config')
const cwd = get(config, 'appimageBuilder.cwd')
const recipe = get(config, 'appimageBuilder.recipe')
const { spawn } = require('child_process');

// const { PassThrough } = require('stream');

console.log('cwd=', cwd)

const ex1 = async () => {
  try {
    const options = {
      cwd,
      // cwd: '/builder/build',
      // env: process.env
    };

    console.log('options=', options)
    const child = spawn(
      'echo',
      [
        'hello'
      ],
      options
    )
    child.stdout.on('data', function(data) {
      console.log('log=',data.toString());
    });
  } catch (err) {
    console.log('error',err)
  }
}

gulp.task('ex1', ex1)

exports.ex1 = ex1
