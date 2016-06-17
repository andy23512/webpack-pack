require! <[fs gulp webpack webpack-dev-server express webpack-dev-middleware webpack-hot-middleware]>

gulp.task \server !->
  # load port and host options
  opt = {
    host: (fs.read-file-sync \option/host encoding: \utf8) - \\n
    dev-port: parseInt fs.read-file-sync \option/dev-port encoding: \utf8
    port: parseInt fs.read-file-sync \option/port encoding: \utf8
  }

  # setup an express server
  require! \express
  app = express!

  # require webpack config
  config = require \./webpack.config.ls

  # using inline mode
    # inline mode: watch and build
    # ref: https://webpack.github.io/docs/webpack-dev-server.html#inline-mode 
  # and using hot module replacement
    # hot mode: livereload
    # ref: https://webpack.github.io/docs/webpack-dev-server.html#hot-module-replacement
  # config.entry.unshift "webpack-dev-server/client?http://#{opt.host}:#{opt.port}", "webpack/hot/dev-server"
  config.entry.unshift "webpack-hot-middleware/client?reload=true"

  # call webpack api
  # https://webpack.github.io/docs/node.js-api.html
  compiler = webpack config
  # call webpackDevServer api
    # ref: https://webpack.github.io/docs/webpack-dev-server.html#api
  app.use webpack-dev-middleware compiler, do
    publicPath: config.output.publicPath
    no-info: true
    stats: {
      colors: true
    }
  app.use webpack-hot-middleware compiler

  # start dev-server at dev-port
  app.listen opt.port


gulp.task \default <[server]>

# vi:et:nowrap
