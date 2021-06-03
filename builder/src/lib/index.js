const { stat, mkdir }  = require('fs/promises');


const mapSeries = async (iterable, action) => {
  for (const x of iterable) {
    await action(x)
  }
}

const ensureDir = async (dir) => {
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
}

module.exports = {
  mapSeries,
  ensureDir
}
