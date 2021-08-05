const execa = require('execa');
const gulp = require('gulp');
const { get } = require('lodash');
const fs = require('fs-extra');
const { stat }  = require('fs/promises');
const { pipeOutput, mapSeries, makeExecutable, ensureRelativeSymlink } = require('@lib');
const config = require('@config');
const binDest = get(config, 'php.binDest');
const cachePath = get(config, 'php.cachePath');
const packages = get(config, 'php.packages');

const getPackageCachePath = (package) => {
  return `${cachePath}/${package.name}`;
};

const getPackageBinPath = (package) => {
  return `${binDest}/bin/${package.name}`;
};

const getPackageSymlinksPaths = (package) => {
  return package.aliases.map((alias) => `${binDest}/bin/${alias}`);
};

const getPackageBins = async (package) => {
  const binPath = getPackageCachePath(package);
  let shouldDownloadBins = false;
  try {
    await stat(binPath);
  } catch (e) {
    // eslint-disable-next-line no-console
    console.log(`cant find ${package.name} bins in cache`);
    shouldDownloadBins = true;
  }

  if (shouldDownloadBins) {
    await fs.ensureDir(cachePath);
    // eslint-disable-next-line no-console
    console.log(`downloading ${package.name} bins`);
    await pipeOutput(execa(
      'wget',
      [
        `--directory-prefix=${cachePath}`,
        `--output-document=${binPath}`,
          package.url,
      ]
    ));
  }
};


gulp.task('get-php-packages-bins', async () => {
  await mapSeries(packages, getPackageBins);
});


const installPhpPharPackage = async (package) => {
  const binCache = getPackageCachePath(package);
  const binPath = getPackageBinPath(package);
  await fs.copy(binCache, binPath);
  await makeExecutable(binPath);
};

gulp.task('prepare-php-phar-packages-bins', async () => {
  await mapSeries(packages, installPhpPharPackage);
});


const preparePhpPharPackageSymlinks = async (package) => {
  try {
    const binPath = getPackageBinPath(package);
    const links = getPackageSymlinksPaths(package);
    await mapSeries(links, async (linkPath) => ensureRelativeSymlink(binPath, linkPath));
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
};

gulp.task('prepare-php-phar-packages-symlinks', async () => {
  await mapSeries(packages, preparePhpPharPackageSymlinks);
});

gulp.task('prepare-php-packages', gulp.series(
  'get-php-packages-bins',
  'prepare-php-phar-packages-bins',
  'prepare-php-phar-packages-symlinks',
));
