const execa = require('execa');
const gulp = require('gulp');
const { pipeOutput } = require('@lib');
const { get } = require('lodash');
const config = require('@config');
const localRepo = get(config, 'xcbproto.localRepo');
const dest = get(config, 'xcbproto.dest');


gulp.task('configure-xcbproto', gulp.series(
  async () => {
    await pipeOutput(execa.command(
      [
        'autoreconf',
        '--install'
      ].join(' '),
      { cwd: localRepo }
    ));
  },
  async () => {
    const env = {
    };
    await pipeOutput(execa(
      './configure',
      [
        `--prefix ${dest}`,
      ],
      {
        cwd: localRepo,
        shell: true,
        env,
      }
    ));
  }
));
