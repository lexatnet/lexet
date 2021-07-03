const execa = require('execa');
const gulp = require('gulp');
const { writeFile }  = require('fs/promises');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const destination = get(config, 'python3.destination');

gulp.task('prepare-python-executables-packages', async () => {

  const content = [
    '#!/usr/bin/env bash',
    'python3 -m pylint $@',
  ].join('\n');

  const scriptPath = `${destination}/bin/pylint`;
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
});
