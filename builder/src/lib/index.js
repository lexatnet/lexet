const { stat, mkdir }  = require('fs/promises');
const execa = require('execa');
const path = require('path');
const fs = require('fs-extra');

const mapSeries = async (iterable, action) => {
  for (const x of iterable) {
    await action(x);
  }
};

const ensureDir = async (dir) => {
  let shouldCreateDir = false;
  try {
    await stat(dir);
    // eslint-disable-next-line no-console
    console.log(`dir ${dir} found`);
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log(`cant find ${dir}`);
    shouldCreateDir = true;
  }

  if (shouldCreateDir) {
    try {
      await mkdir(dir, { recursive: true});
      // eslint-disable-next-line no-console
      console.log(`dir ${dir} created`);
    } catch (e) {
      // eslint-disable-next-line no-console
      console.log(`cant create dir ${dir}`, e);
    }
  }
};

const bindOutput = (childProcess) => {
  childProcess.stdout.pipe(process.stdout);
  childProcess.stderr.pipe(process.stderr);
};


const pipeOutput = async (proc) => {
  bindOutput(proc);
  return proc;
};

const symlink = async (target, link) => {
  const child = execa(
    'ln',
    [
      '--symbolic',
      target,
      link
    ]
  );

  bindOutput(child);
  await child;
};


const relativeSymlink = async (target, link) => {
  const child = execa(
    'ln',
    [
      '--symbolic',
      '--relative',
      target,
      link
    ]
  );

  bindOutput(child);
  await child;
};

const ensureRelativeSymlink = async (destPath, linkPath) => {
  const linkExists = await fs.pathExists(linkPath);
  if (!linkExists) {
    const linkDir = path.dirname(linkPath);
    await fs.ensureDir(linkDir);
    await relativeSymlink(destPath, linkPath);
  } else {
    // eslint-disable-next-line no-console
    console.log('link exists');
  }
};

const makeExecutable = async (path) => {
  await pipeOutput(execa(
    'chmod',
    [
      '+x',
      path
    ]
  ));
};

module.exports = {
  mapSeries,
  ensureDir,
  bindOutput,
  symlink,
  ensureRelativeSymlink,
  relativeSymlink,
  pipeOutput,
  makeExecutable,
};
