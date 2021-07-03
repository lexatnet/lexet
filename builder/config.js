const build_root = '/staff/build';
const appDir = `${build_root}/workspace/AppDir`;

const python3 = {
  srcUrl: 'https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz',
  srcTar: 'python-src.tgz',
  localRepoCache: `${build_root}/.cache/python3/src`,
  localRepo: `${build_root}/workspace/python3/src`,
  destination: `${appDir}/usr/python3`,
  executable: `${appDir}/usr/python3/bin/python3.9`,
  pythonPath: `${appDir}/usr/python3/lib/python3.9`,
  venv: `${appDir}/venv`,
  packagesPrefix: `${appDir}/usr/python3/bin/python3`,
  packagesExecPrefix: `${appDir}/usr/python3/lib/python3.9`
};
python3.pythonSrc = `${python3.localRepoCache}/${python3.srcTar}`;

const ctags = {
  srcUrl: 'https://github.com/universal-ctags/ctags.git',
  cachePath: `${build_root}/.cache/ctags`,
  localRepo: `${build_root}/workspace/ctags/src`,
  destination: `${appDir}/usr/ctags`,
};
ctags.srcCache = `${ctags.cachePath}/src`;

const appimageBuilder = {
  recipe: '/lexet/recipe.yml',
  appDir,
  cwd: `${build_root}/workspace`,
};

const lexet = {
  src: '/lexet/src',
  dest: `${appDir}/lexet`,
  iconSrc: '/builder/icons/lex.svg',
  // iconDest: `${appDir}/usr/share/icons/hicolor/scalable/apps/lex.svg`,
  iconDest: `${appDir}/lexet.svg`,
  appRunScriptSrc: '/lexet/AppRun',
  appRunScriptDest: `${appDir}/AppRun`,
  desktopDest: `${appDir}/lexet.desktop`
};

const nvm = {
  root: `${appDir}/env/nvm`,
  init: `${appDir}/init/nvm.sh`,
  appimageNvmRoot: '${APPDIR}/env/nvm',
  defaultPackages: [
    'gulp',
    'eslint',
    'babel-eslint',
    'eslint-plugin-json',
    'eslint-plugin-import',
    'eslint-plugin-node',
    'jshint',
    'jscs',
    'prettier',
    '@prettier/plugin-xml',
    'node-gyp'
  ]
};

const atom = {
  binUrl: 'https://github.com/atom/atom/releases/download/v1.57.0/atom-amd64.tar.gz',
  binZip: 'atom.tar.gz',
  binCache: `${build_root}/.cache/atom/bin`,
  dest: `${appDir}/atom`,
};

const appimagetool = {
  appDir,
  cwd: `${build_root}/workspace`,
};

module.exports = {
  buildRoot: build_root,
  python3,
  appimageBuilder,
  lexet,
  nvm,
  atom,
  appimagetool,
  ctags,
};
