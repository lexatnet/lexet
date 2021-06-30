const gulp = require('gulp');
const del = require('del');
const { get } = require('lodash');

const { stat, mkdir }  = require('fs/promises');
const config = require('@config')
const { ensureDir, mapSeries } = require('@lib')

const root = get(config, 'appimageBuilder.appDir')

const dirTree = [
  `${root}/env`,
  `${root}/init`,
  `${root}/bin`,
  `${root}/lib`,
  `${root}/usr/share/icons/hicolor/scalable/apps`
]

const prepareAppimageDirTree = async () => {
  await mapSeries(dirTree, ensureDir)
}

gulp.task('prepare-appimage-dir-tree', prepareAppimageDirTree)


const execa = require('execa');
const { bindOutput } = require('@lib')

const createShSymlink = async () => {
  try {
    const child = execa(
      'ln',
      [
        '--symbolic',
        'bash',
        `${root}/bin/sh`
      ]
    );

    bindOutput(child)
    await child;
  } catch (err) {
    console.log(err)
  }
}

gulp.task('createShSymlink', createShSymlink)

exports.prepareAppimageDirTree = prepareAppimageDirTree
