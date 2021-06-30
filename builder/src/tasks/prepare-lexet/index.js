const gulp = require('gulp');
const { get } = require('lodash');
const execa = require('execa');

const { ensureDir, bindOutput } = require('@lib')

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
  bindOutput(cp),
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
  bindOutput(cp)
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
  bindOutput(cp)
  await cp
}

gulp.task('copyIcon', copyIcon)
gulp.task('copyAppRunScript', copyAppRunScript)

const prepareLexet = gulp.series(
  copyLexet,
  copyIcon,
  copyAppRunScript
)

gulp.task('prepareLexet', prepareLexet)

exports.prepareLexet = prepareLexet
