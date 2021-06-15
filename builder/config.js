
module.exports = {
  python3: {
    pythonSrcRoot: 'Python-3.9.5',
    srcTar: 'python-src.tgz',
    localRepoCache: '/builder/build/.cache/python3/src',
    localRepo: '/builder/build/workspace/python3/src',
    srcUrl: 'https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz',
    destination: '/builder/build/workspace/AppDir/usr/python3',
    executable: '/builder/build/workspace/AppDir/usr/python3/bin/python3',
    venv: '/builder/build/workspace/AppDir/venv'
  },
  appimageBuilder: {
    recipe: '/lexet/recipe.yml',
    appDir: '/builder/build/workspace/AppDir',
    cwd: '/builder/build/workspace',
  },
  lexet: {
    src: '/lexet/src',
    dest: '/bulder/build/AppDir/lexet',
    iconSrc: '/builder/icons/lex.svg',
    iconDest: '/builder/build/workspace/AppDir/usr/share/icons/hicolor/scaleable/apps/lex.svg',
    appRunScriptSrc: '/lexet/AppRun',
    appRunScriptDest: '/builder/build/workspace/AppDir/AppRun'
  },
  nvm: {
    root: '/builder/build/workspace/AppDir/usr/nvm',
    init: '/builder/build/workspace/AppDir/init/nvm.sh',
    appimageNvmRoot: '${APPDIR}/usr/nvm'
  }
}
