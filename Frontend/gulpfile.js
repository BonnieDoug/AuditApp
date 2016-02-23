var gulp = require('gulp');
var sass = require('gulp-sass');


// source and distribution folder
var
    source = 'assets/src/',
    dest = 'assets/dist/';

// Bootstrap scss source
var jQuery = {
        in: './bower_components/jquery/'
    };
    
// Bootstrap scss source
var bootstrapSass = {
        in: './bower_components/bootstrap-sass/'
    };
    
// fonts
var fonts = {
        in: [source + 'fonts/*.*', bootstrapSass.in + 'assets/fonts/**/*'],
        out: dest + 'fonts/'
    };
    
// Bootstrap JS
var bsjs = {
        in: [source + 'javascripts/*.*', bootstrapSass.in + 'assets/javascripts/**/*'],
        out: dest + 'javascripts/'
    };

// JQuery JS
var jqueryjs = {
        in: [source + 'javascripts/*.*', jQuery.in + 'dist/**'],
        out: dest + 'javascripts/'
    };

// css source file: .scss files
var css = {
    in: source + 'css/main.scss',
    out: dest + 'css/',
    watch: source + 'css/**/*',
    sassOpts: {
        outputStyle: 'nested',
        precison: 3,
        errLogToConsole: true,
        includePaths: [bootstrapSass.in + 'assets/stylesheets']
    }
};

// copy bootstrap required fonts to dest
gulp.task('fonts', function () {
    return gulp
        .src(fonts.in)
        .pipe(gulp.dest(fonts.out));
});

// copy jquery required js to dest
gulp.task('jqueryjs', function () {
    return gulp
        .src(jqueryjs.in)
        .pipe(gulp.dest(jqueryjs.out));
});

// copy bootstrap required js to dest
gulp.task('bsjs', function () {
    return gulp
        .src(bsjs.in)
        .pipe(gulp.dest(bsjs.out));
});

// compile scss
gulp.task('sass', ['fonts','bsjs','jqueryjs'], function () {
    return gulp.src(css.in)
        .pipe(sass(css.sassOpts))
        .pipe(gulp.dest(css.out));
});

// default task
gulp.task('default', ['sass'], function () {
     gulp.watch(css.watch, ['sass']);
});