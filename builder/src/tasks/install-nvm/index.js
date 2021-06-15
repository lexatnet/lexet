const gulp = require('gulp');
const execa = require('execa');
const { get } = require('lodash');
const { writeFile }  = require('fs/promises');

const config = require('@config')
const nvmRoot = get(config, 'nvm.root')
const nvmInitScriptPath = get(config, 'nvm.init')
const appimageNvmRoot  = get(config, 'nvm.appimageNvmRoot')

const installNvm = async () => {
  let clone = execa.command(
    [
      `[ -d ${nvmRoot} ]`,
      `git clone https://github.com/nvm-sh/nvm.git ${nvmRoot}`
    ].join(' || '),
    {
      shell: '/bin/bash',
    }
  );
  clone.stdout.pipe(process.stdout)
  await clone

  const {
      stdout: commits
  } =  await execa.command(
      [
          'git',
          'rev-list',
          '--tags',
          '--max-count=1',

      ].join(' '),
      { cwd: nvmRoot }
  )

  const { stdout: tag } =  await execa.command(
      [
          'git',
          'describe',
          '--abbrev=0',
          '--tags',
          '--match "v[0-9]*"',
           commits

      ].join(' '),
      {
        shell: '/bin/bash',
        cwd: nvmRoot
      }
  )

  const checkout =  execa.command(
    [
        'git',
        'checkout',
        tag
    ].join(' '),
    {
      shell: '/bin/bash',
      cwd: nvmRoot
    }
  );
  checkout.stdout.pipe(process.stdout)
  await checkout
}

const createNvmInitScript =  async () => {
  const nvmInitScript = [
    `export NVM_DIR=${appimageNvmRoot}`,
    `[ -s "${appimageNvmRoot}/nvm.sh" ] && \. "${appimageNvmRoot}/nvm.sh"`,
    `[ -s "${appimageNvmRoot}/bash_completion" ] && \. "${appimageNvmRoot}/bash_completion"  # This loads nvm bash_completion`
  ].join('\n');
  try {
    await writeFile(nvmInitScriptPath, nvmInitScript);
  } catch (err) {
    console.log(err)
  }
}


const defaultPackages = [
  'gulp',
  'eslint',
  'babel-eslint',
  'eslint-plugin-json',
  'jshint',
  'jscs',
  'prettier',
  '@prettier/plugin-xml',
  'node-gyp'
]

const createDefaultPackagesFile = async () => {
  try {
    await writeFile(`${nvmRoot}/default-packages`, defaultPackages.join('\n'));
  } catch (err) {
    console.log(err)
  }
}

const installNode = async () => {
  try {
    const child =  execa.command(
        [
          `NVM_DIR=${nvmRoot}`,
          `source ${nvmRoot}/nvm.sh --no-use`,
          'nvm ls-remote',
          'nvm install node'
        ].join(' && '),
        {
          // cwd: nvmRoot,
          shell: '/bin/bash',
          env: {
            NVM_DIR: nvmRoot
          }
        }
    )

    child.stdout.pipe(process.stdout)
    child.stderr.pipe(process.stderr)
    await child
  } catch (err) {
    console.log(err)
  }
}

exports.installNvm = gulp.series(
  installNvm,
  createNvmInitScript,
  createDefaultPackagesFile,
  installNode
)
