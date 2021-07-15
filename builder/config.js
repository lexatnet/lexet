const buildRoot = '/staff/build';
const appDir = `${buildRoot}/workspace/AppDir`;

const python3 = {
  srcUrl: 'https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz',
  srcTar: 'python-src.tgz',
  localRepoCache: `${buildRoot}/.cache/python3/src`,
  localRepo: `${buildRoot}/workspace/python3/src`,
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
  cachePath: `${buildRoot}/.cache/ctags`,
  localRepo: `${buildRoot}/workspace/ctags/src`,
  destination: `${appDir}/usr/ctags`,
};
ctags.srcCache = `${ctags.cachePath}/src`;

const hunspell = {
  srcUrl: 'https://github.com/hunspell/hunspell.git',
  cachePath: `${buildRoot}/.cache/hunspell`,
  localRepo: `${buildRoot}/workspace/hunspell/src`,
  libDest: `${appDir}/usr/hunspell/lib`,
  binDest: `${appDir}/usr/hunspell/bin`,
};
hunspell.srcCache = `${hunspell.cachePath}/src`;

const appimage = {
  appDir,
  cwd: `${buildRoot}/workspace`,
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
  binCache: `${buildRoot}/.cache/atom/bin`,
  dest: `${appDir}/atom`,
  atomHome: `${appDir}/atom-home-template`,
  packages: [
    'git-blame',
    'git-diff',
    'linter',
    'linter-ui-default',
    'linter-eslint',
    'linter-pylint',
    // 'linter-spell', // (?)
    'intentions',
    'highlight-selected',
    'minimap',
    'minimap-selection',
    'minimap-linter',
    'minimap-highlight-selected',
    'minimap-find-and-replace',
    'minimap-git-diff',
    'prettier-atom',
    'split-diff',
    'project-manager',
    'platformio-ide-terminal',
    'color-picker',
    'file-icons',

    'symbols-tree-view',
    'autocomplete-plus',
    'atom-ctags',
    'change-case',
    'advanced-open-file',
  ],
  configTemplateSrc: '/lexet/config/atom.config.template.cson',
  configTemplateDest: `${appDir}/atom-home-template/config.cson`
};
atom.binsPath = `${atom.binCache}/${atom.binZip}`;

module.exports = {
  buildRoot,
  python3,
  appimage,
  lexet,
  nvm,
  atom,
  ctags,
  hunspell,
};
