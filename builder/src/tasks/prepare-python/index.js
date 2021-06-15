const execa = require('execa');
const gulp = require('gulp');
const { get } = require('lodash');
const { stat, mkdir }  = require('fs/promises');

const { ensureDir } = require('@lib')

const config = require('@config')
const localRepo = get(config, 'python3.localRepo')
const localRepoCache = get(config, 'python3.localRepoCache')
const srcTar = get(config, 'python3.srcTar')
const destination = get(config, 'python3.destination')
const executable = get(config, 'python3.executable')
const venv = get(config, 'python3.venv')
const pythonSrc =  `${localRepoCache}/${srcTar}`;
const extractedSrc = `${localRepo}/Python-3.9.5`;

const getPythonSources = async () => {

  let shouldDownloadSources = false
  try {
    await stat(pythonSrc)
  } catch (e) {
    console.log('cant find python 3 sources in cache')
    shouldDownloadSources = true
  }

  if (shouldDownloadSources) {
    await ensureDir(localRepoCache)
    console.log('downloading python 3 sources')
    const wget = execa(
      'wget',
      [
        // `--directory-prefix=${localRepoCache}`,
        `--output-document=${pythonSrc}`,
          get(config, 'python3.srcUrl'),
      ]
    );
    wget.stdout.pipe(process.stdout)
    await wget
  }
}

const copyPythonSources = async () => {
  await ensureDir(localRepo)
  const sourcesTar = `${localRepoCache}/`
  const child = execa(
    'cp',
    [
      '-r',
      pythonSrc,
      localRepo
    ]
  );
  child.stdout.pipe(process.stdout)
  await child
}

const extractPythonSources = async () => {
  await execa.command(
    [
      'tar',
      '-xvf',
      srcTar
    ].join(' '),
    { cwd: localRepo }
  );
}


const buildPython = async () => {

  const configure =  execa.command(
    [
      './configure',
      '--enable-optimizations',
      '--with-ensurepip=install',
      `--prefix ${destination}`
      // LDFLAGS="-L${libs}"
      // CFLAGS="${includes} -I${prefix}/includes/python3.9/iternal"
    ].join(' '),
    { cwd: extractedSrc }
  );
  configure.stdout.pipe(process.stdout)
  await configure

  await ensureDir(destination)

  try {
    const make = execa(
      'make',
      [
        '-j8'
      ],
      { cwd: extractedSrc }
    );
    make.stdout.pipe(process.stdout)
    await make
  } catch (e) {
    console.log('cant make', e)
  }
}

const installPython = async () => {

  try {
    const child = execa(
      'make',
      [
        'install'
      ],
      { cwd: extractedSrc }
    );
    child.stdout.pipe(process.stdout)
    await child
  } catch (e) {
    console.log('cant install', e)
  }
}


const setupVirtualEnvironment = async () => {
  try {
    const child = execa(
      executable,
      [
        '-m venv',
        venv
      ]
    );
    child.stdout.pipe(process.stdout)
    child.stderr.pipe(process.stderr),
    {
      shell: true,
    }
    await child
  } catch (e) {
    console.log('cant install', e)
  }
}

const preparePython = gulp.series(
  getPythonSources,
  copyPythonSources,
  extractPythonSources,
  buildPython,
  installPython
);

gulp.task('prepare-python', preparePython)
gulp.task('installPython', installPython)
gulp.task('buildPython', buildPython)
gulp.task('setupVirtualEnvironment', setupVirtualEnvironment)
exports.preparePython = preparePython
