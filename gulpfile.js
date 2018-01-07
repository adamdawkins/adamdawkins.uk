var gulp = require('gulp');
var postcss = require('gulp-postcss');
var cleanCSS = require('gulp-clean-css');
var cssvariables = require('postcss-css-variables');

function minify(done) {
	return gulp.src('./app/imports/styles/*.css')
		.pipe(postcss([cssvariables()]))
		.pipe(cleanCSS({ level: 2 }))
		.pipe(gulp.dest('./app/public/styles'))
	done();
}

gulp.task('default', minify);
gulp.task('watch', function() {
	gulp.watch("./app/imports/styles/*.css", ['default']);
})
