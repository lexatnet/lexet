const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');

const config = require('@config')
const lexetSrc = get(config, 'lexet.src')
const lexetDest = get(config, 'lexet.dest')
const appRunScriptSrc = get(config, 'lexet.appRunScriptSrc')
const appRunScriptDest = get(config, 'lexet.appRunScriptDest')

const copyLexet = async () => {
  console.log('copylexet()')

  const cp = execa(
    'cp',
    [
      '-r',
      lexetSrc,
      lexetDest
    ]
  );
  cp.stdout.pipe(process.stdout)
  await cp
}

const copyAppRunScript = async () => {
  console.log('copyAppRunScript()')

  const cp = execa(
    'cp',
    [
      '-r',
      appRunScriptSrc,
      appRunScriptDest
    ]
  );
  cp.stdout.pipe(process.stdout)
  await cp
}

exports.prepareLexet = gulp.series(
  copyLexet,
  copyAppRunScript
)
