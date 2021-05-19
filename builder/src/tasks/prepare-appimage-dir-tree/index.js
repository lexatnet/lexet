const gulp = require('gulp');
const del = require('del');

const { stat, mkdir }  = require('fs/promises');

const root = '/bulder/build/AppDir'

const dirTree = [
  `${root}/bin`,
  `${root}/lib`
]

const prepareAppimageDirTree = async () => {
  dirTree.each((dir) => {
    let shouldCreateDir = false;
    try {
      await stat(dir)
      console.log(`dir ${dir} found`)
    } catch (e) {
      console.log(`cant find ${dir}`)
      shouldCreateDir = true
    }

    if (shouldCreateDir) {
      try {
        await mkdir(dir, { recursive: true})
        console.log(`dir ${dir} created`)
      } catch (e) {
        console.log(`cant create dir ${dir}`, e)
      }
    }
  })
}

exports.prepareAppimageDirTree = prepareAppimageDirTree
