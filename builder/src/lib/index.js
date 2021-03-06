const { stat, mkdir }  = require('fs/promises');
const execa = require('execa');


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

const bindOutput = (childProcess) => {
  childProcess.stdout.pipe(process.stdout)
  childProcess.stderr.pipe(process.stderr)
}


const pipeOutput = async (proc) => {
  bindOutput(proc)
  return proc
}

const symlink = async (target, link) => {
  const child = execa(
    'ln',
    [
      '--symbolic',
      target,
      link
    ]
  );

  bindOutput(child)
  await child;
}

module.exports = {
  mapSeries,
  ensureDir,
  bindOutput,
  symlink,
  pipeOutput
}
