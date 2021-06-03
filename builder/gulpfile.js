require('module-alias/register')

const gulp = require('gulp');

const { build }  = require('@tasks/build');
const { clean }  = require('@tasks/clean');
const { buildAppimage }  = require('@tasks/build-appimage');

gulp.task('build', build)
gulp.task('clean', clean)
gulp.task('build-appimage', buildAppimage)

exports.default = gulp.series(clean, build)
