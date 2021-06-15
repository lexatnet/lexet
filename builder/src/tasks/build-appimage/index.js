const gulp = require('gulp');
const del = require('del');
const { get } = require('lodash');
const execa = require('execa');

const config = require('@config')
const cwd = get(config, 'appimageBuilder.cwd')
const recipe = get(config, 'appimageBuilder.recipe')

const { PassThrough } = require('stream');

const buildAppimage = async () => {
  try {
    const child = execa(
      'appimage-builder',
      [
        // '--appimage-extract-and-run',
        `--recipe ${recipe}`,
        '--skip-test'
      ],
      {
        shell: true,
        cwd,
        // env: {
        //   APPIMAGE_EXTRACT_AND_RUN:1
        // }
      }
    );

    child.stdout.pipe(process.stdout);
    child.stderr.pipe(process.stderr);
    await child;
  } catch (err) {
    console.log(err)
  }
}

exports.buildAppimage = buildAppimage
