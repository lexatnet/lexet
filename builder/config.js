const build_root = '/staff/build'

const python3 = {
  pythonSrcRoot: 'Python-3.9.5',
  srcTar: 'python-src.tgz',
  localRepoCache: `${build_root}/.cache/python3/src`,
  localRepo: `${build_root}/workspace/python3/src`,
  srcUrl: 'https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz',
  destination: `${build_root}/workspace/AppDir/usr/python3`,
  executable: `${build_root}/workspace/AppDir/usr/python3/bin/python3`,
  venv: `${build_root}/workspace/AppDir/venv`
}

const appimageBuilder = {
  recipe: '/lexet/recipe.yml',
  appDir: `${build_root}/workspace/AppDir`,
  cwd: `${build_root}/workspace`,
}

const lexet = {
  src: '/lexet/src',
  dest: `${build_root}/workspace/AppDir/lexet`,
  iconSrc: '/builder/icons/lex.svg',
  iconDest: `${build_root}/workspace/AppDir/usr/share/icons/hicolor/scalable/apps/lex.svg`,
  appRunScriptSrc: '/lexet/AppRun',
  appRunScriptDest: `${build_root}/workspace/AppDir/AppRun`
}

const nvm = {
  root: `${build_root}/workspace/AppDir/usr/nvm`,
  init: `${build_root}/workspace/AppDir/init/nvm.sh`,
  appimageNvmRoot: '${APPDIR}/usr/nvm'
}

module.exports = {
  buildRoot: build_root,
  python3,
  appimageBuilder,
  lexet,
  nvm
}
