require('module-alias/register')

const gulp = require('gulp');

const { build }  = require('@tasks/build');
const { clean }  = require('@tasks/clean');

gulp.task('build', build)
gulp.task('clean', clean)

exports.default = gulp.series(clean, build)
