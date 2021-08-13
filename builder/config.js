const buildRoot = '/staff/build';
const appDir = `${buildRoot}/workspace/AppDir`;


const python3 = {
  srcUrl: 'https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tgz',
  srcTar: 'python-src.tgz',
  localRepoCache: `${buildRoot}/.cache/python3/src`,
  localRepo: `${buildRoot}/workspace/python3/src`,
  destination: `${appDir}/usr/python3`,
  executable: `${appDir}/usr/python3/bin/python3.9`,
  packagesDest: `${appDir}/usr/python3/packages`,
  pythonPath: `${appDir}/usr/python3/lib/python3.9`,
  venv: `${appDir}/venv`,
  packagesPrefix: `${appDir}/usr/python3/bin/python3`,
  packagesExecPrefix: `${appDir}/usr/python3/lib/python3.9`,
  packages: [
      'pylint',
      'pytest',
  ],
};
python3.pythonSrc = `${python3.localRepoCache}/${python3.srcTar}`;

const bash = {
  srcUrl: 'https://git.savannah.gnu.org/git/bash.git',
  cachePath: `${buildRoot}/.cache/bash`,
  localRepo: `${buildRoot}/workspace/bash/src`,
  destination: `${appDir}/usr/bash`,
};
bash.srcCache = `${bash.cachePath}/src`;

const ctags = {
  srcUrl: 'https://github.com/universal-ctags/ctags.git',
  cachePath: `${buildRoot}/.cache/ctags`,
  localRepo: `${buildRoot}/workspace/ctags/src`,
  destination: `${appDir}/usr/ctags`,
};
ctags.srcCache = `${ctags.cachePath}/src`;

const ruby = {
  srcUrl: 'https://github.com/ruby/ruby.git',
  cachePath: `${buildRoot}/.cache/ruby`,
  localRepo: `${buildRoot}/workspace/ruby/src`,
  // destination: `${appDir}/usr/ruby`,
  libDest: `${appDir}/usr/ruby/lib`,
  binDest: `${appDir}/usr/ruby/bin`,
  packages: [
      'rubocop',
      'rubocop-rspec',
      'ruby-lint',
  ],
};
ruby.srcCache = `${ruby.cachePath}/src`;

const php = {
  srcUrl: 'https://github.com/php/php-src.git',
  cachePath: `${buildRoot}/.cache/php`,
  localRepo: `${buildRoot}/workspace/php/src`,
  // destination: `${appDir}/usr/php`,
  iniDir: `${appDir}/usr/php/config`,
  libDest: `${appDir}/usr/php/lib`,
  binDest: `${appDir}/usr/php/bin`,
  extDir: `${appDir}/usr/php/extensions`,
  packages: [
    {
      type: 'phar',
      name: 'composer.phar',
      url: 'https://getcomposer.org/composer.phar',
      aliases: ['composer']
    },
    {
      type: 'phar',
      name: 'phpcs.phar',
      url: 'https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar',
      aliases: ['phpcs']
    },
    {
      type: 'phar',
      name: 'phpcbf.phar',
      url: 'https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar',
      aliases: ['phpcbf']
    },
  ],
};
php.iniDest = `${php.iniDir}/php.ini`;
php.srcCache = `${php.cachePath}/src`;


const glib = {
  srcUrl: 'https://gitlab.gnome.org/GNOME/glib.git',
  cachePath: `${buildRoot}/.cache/glib`,
  localRepo: `${buildRoot}/workspace/glib/src`,
  buildDir: '_build',
  dest: `${appDir}/usr/glib`,
};
glib.srcCache = `${glib.cachePath}/src`;

const gtksourceview = {
  srcUrl: 'https://gitlab.gnome.org/GNOME/gtksourceview.git',
  cachePath: `${buildRoot}/.cache/gtksourceview`,
  localRepo: `${buildRoot}/workspace/gtksourceview/src`,
  buildDir: '_build',
  dest: `${appDir}/usr/gtksourceview`,
};
gtksourceview.srcCache = `${gtksourceview.cachePath}/src`;

const meld = {
  srcUrl: 'https://gitlab.gnome.org/GNOME/meld.git',
  cachePath: `${buildRoot}/.cache/meld`,
  localRepo: `${buildRoot}/workspace/meld/src`,
  buildDir: '_build',
  dest: `${appDir}/usr/meld`,
};
meld.srcCache = `${meld.cachePath}/src`;

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
  atomHomeTemplate: `${appDir}/atom-home-template`,
  atomHomeCache: `${buildRoot}/.cache/atom/home`,
  packages: [
    'git-blame',
    // 'git-diff', // part of core
    'linter',
    'linter-ui-default',
    'linter-eslint',
    'linter-pylint',
    'linter-rubocop',
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
    // 'autocomplete-plus',  // part of core
    'atom-ctags',
    'change-case',
    'advanced-open-file',
    'atom-beautify',
    'linter-phpcs',
  ],
  configTemplateSrc: '/lexet/config/atom.config.template.cson',
  configTemplateDest: `${appDir}/atom-home-template/config.cson`
};
atom.binsPath = `${atom.binCache}/${atom.binZip}`;

module.exports = {
  buildRoot,
  appDir,
  appimage,
  python3,
  bash,
  nvm,
  php,
  ruby,
  atom,
  ctags,
  hunspell,
  lexet,
  glib,
  gtksourceview,
  meld,
};
