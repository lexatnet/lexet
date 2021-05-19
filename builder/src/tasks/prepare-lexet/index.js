const gulp = require('gulp');

const { stat, mkdir }  = require('fs/promises');

const copyLexet = async () => {
  console.log('copyPythonSources()')

  let souldCreateLocalRepo = false
  try {
    await stat(localRepo)
  } catch (e) {
    console.log('local repo doesn\'t exists')
    souldCreateLocalRepo = true
  }

  if (souldCreateLocalRepo) {
    try {
      await mkdir(localRepo, { recursive: true})
    } catch (e) {
      console.log('cant create local repo', e)
    }

    try {
      console.log(await stat(localRepo))
    } catch (e) {
      console.log('local repo still doesn\'t exists')
      souldCreateLocalRepo = true
    }
  }

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

exports.prepareLexet = gulp.series(
  copyLexet
)
