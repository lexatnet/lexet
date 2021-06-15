const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');

const { ensureDir } = require('@lib')

const config = require('@config')
const lexetSrc = get(config, 'lexet.src')
const lexetDest = get(config, 'lexet.dest')
const appRunScriptSrc = get(config, 'lexet.appRunScriptSrc')
const appRunScriptDest = get(config, 'lexet.appRunScriptDest')
const iconSrc = get(config, 'lexet.iconSrc')
const iconDest = get(config, 'lexet.iconDest')

const copyLexet = async () => {
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

const copyIcon = async () => {
  const cp = execa(
    'cp',
    [
      '-r',
      iconSrc,
      iconDest
    ]
  );
  cp.stdout.pipe(process.stdout)
  await cp
}

gulp.task('copyIcon', copyIcon)

gulp.task('copyAppRunScript', copyAppRunScript)

const prepareLexet = gulp.series(
  copyLexet,
  copyIcon,
  copyAppRunScript
)

exports.prepareLexet = prepareLexet
