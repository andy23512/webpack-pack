require! <[fs gulp webpack webpack-dev-server express webpack-dev-middleware webpack-hot-middleware]>

gulp.task \server !->
  # load port and host options
  opt = {
    host: (fs.read-file-sync \option/host encoding: \utf8) - \\n
    port: parseInt fs.read-file-sync \option/port encoding: \utf8
  }

  # require webpack config
  config = require \./webpack.config.ls

  # prepend hot middleware client to entry point
  switch typeof! config.entry
  | \String =>
    config.entry = ["webpack-hot-middleware/client?reload=true", config.entry]
  | \Array =>
    config.entry.unshift "webpack-hot-middleware/client?reload=true"
  | \Object =>
    for entry-name, entry in config.entry
      switch typeof! entry
      | \String =>
        entry = ["webpack-hot-middleware/client?reload=true", entry]
      | \Array =>
        entry.unshift "webpack-hot-middleware/client?reload=true"

  # call webpack api
  # https://webpack.github.io/docs/node.js-api.html
  compiler = webpack config

  # setup an express server
  require! \express
  app = express!

  # using webpack-dev-middleware
  # https://github.com/webpack/webpack-dev-middleware
  app.use webpack-dev-middleware compiler, do
    publicPath: config.output.publicPath
    no-info: true
    stats: {
      colors: true
    }

  # using webpack-hot-middleware
  # https://github.com/glenjamin/webpack-hot-middleware
  app.use webpack-hot-middleware compiler

  # start server at port
  app.listen opt.port


gulp.task \default <[server]>

# vi:et:nowrap
