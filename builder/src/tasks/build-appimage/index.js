const gulp = require('gulp');
const del = require('del');
const { get } = require('lodash');

const config = require('@config')
const cwd = get(config, 'appimageBuilder.cwd')
const recipe = get(config, 'appimageBuilder.recipe')

const buildAppimage = async () => {
  console.log('downloading python 3 sources')
  await execa.command(
    [
      'appimage-builder',
      `--recipe ${recipe}`
    ].join(' '),
    { cwd }
  );
  const appimageBuilder = execa(

  );
  buildAppimage.stdout.pipe(process.stdout)
  await buildAppimage
}

exports.buildAppimage = buildAppimage
