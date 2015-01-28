gulp = require 'gulp'

gulp.task 'watch', ->
  gulp.watch 'coffee/*.coffee',['coffee']
  gulp.watch 'sass/*.sass',['styles']
  gulp.watch 'gulpfile.coffee',['coffee','styles']
  gulp.watch 'views/*.jade',['views']

gulp.task 'express', ->
  express = require 'express'
  app = express()
  app.use(express.static(__dirname))
  app.get '/:id', (req, res) ->
    res.send req.params.id
  app.listen 4000

gulp.task 'coffee',->
  coffee = require 'gulp-coffee'
  gulp.src 'coffee/*.coffee'
  .pipe coffee()
  .pipe gulp.dest 'scripts'

sass = require 'gulp-ruby-sass'
autoprefixer = require 'gulp-autoprefixer'
minifycss = require 'gulp-minify-css'
rename = require 'gulp-rename'

gulp.task 'styles', ->
  gulp.src('sass/*.sass')
  .pipe(sass({ style: 'expanded' }))
  .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1'))
  .pipe(gulp.dest('css'))
  .pipe(rename({suffix: '.min'}))
  .pipe(minifycss())
  .pipe(gulp.dest('css'))

jade = require 'gulp-jade'

gulp.task 'views', ->
  gulp.src('views/*.jade')
  .pipe(jade())
  .pipe(gulp.dest('www'))

gulp.task 'default',['express', 'watch']