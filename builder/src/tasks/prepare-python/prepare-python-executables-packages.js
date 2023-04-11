const execa = require('execa');
const gulp = require('gulp');
const { writeFile }  = require('fs/promises');
const { pipeOutput, mapSeries } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const destination = get(config, 'python3.destination');
const packages = get(config, 'python3.packages');

const preparePythonPackageExecutable = async (package) => {
  const content = [
    '#!/usr/bin/env bash',
    `python3 -m ${package} "$@"`,
  ].join('\n');

  const scriptPath = `${destination}/bin/${package}`;
  try {
    await writeFile(scriptPath, content);
    await pipeOutput(execa(
      'chmod',
      [
        '+x',
        scriptPath
      ]
    ));
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
};

gulp.task('prepare-python-executables-packages', async () => {
  await mapSeries(packages, preparePythonPackageExecutable);
});
