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
  `${root}/usr/share/icons`
]

const prepareAppimageDirTree = async () => {
  await mapSeries(dirTree, ensureDir)
}

gulp.task('prepare-appimage-dir-tree', prepareAppimageDirTree)

exports.prepareAppimageDirTree = prepareAppimageDirTree
