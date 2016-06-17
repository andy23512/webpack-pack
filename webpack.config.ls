require! <[fs html-webpack-plugin nib webpack bower-webpack-plugin]>

# read opt
opt =
  host: (fs.read-file-sync \option/host encoding: \utf8) - \\n
  port: parseInt fs.read-file-sync \option/port encoding: \utf8

# ref: https://webpack.github.io/docs/configuration.html
module.exports =
  dev-server: # ref: https://webpack.github.io/docs/webpack-dev-server.html#content-base
    # content-base: folder that dev-server serve the file from 
    content-base: \dist
    # host setting
    host: \0.0.0.0
    # inline mode (watch and build)
    inline: true
  # entry: entry point of the bundle
  entry: <[./app/app.ls]>
  context: __dirname
  module:
    loaders: # https://webpack.github.io/docs/configuration.html#module-loaders
      * test: /\.(jade|pug)$/ loader: \jade # test: match files, loader: applied loader to the matched files
      * test: /\.json$/ loader: \json
      * test: /\.jsx?$/ exclude: /\/node_modules\// loader: \babel
      * test: /\.ls$/ loader: \livescript
      * test: /\/res\/image\// loader: \url?limit=10000
      * test: /\.styl$/ loader: \style!css!stylus
      * test: /\.css$/ loader: \style!css
      * test: /\.(eot|ico|jpg|mp3|svg|ttf|woff2|woff|png?)($|\?)/ loader: \file
  output:
    filename: \app.js # output single js file
    path: __dirname + \/dist # output path
    public-path: "http://#{opt.host}:#{opt.port}/"
  plugins: # Additional plugins. ref: https://github.com/webpack/docs/wiki/list-of-plugins
    * new webpack.optimize.OccurenceOrderPlugin! #!
    # Enables Hot Module Replacement
    * new webpack.HotModuleReplacementPlugin!
    * new webpack.NoErrorsPlugin! #!
    # Automatically loaded modules. The keys are as variables corresponding to the modules.
    * new webpack.Provide-plugin $: \jquery jQuery: \jquery app: \app.ls moment: \moment React: \react
    # Generate simple html file. ref: https://www.npmjs.com/package/html-webpack-plugin
    * new html-webpack-plugin do
        # favicon: \app/res/image/favicon.ico
        # inject: place to inject all assets
        inject: \body
        # template: path to template
        template: \app/index.pug
    * new bower-webpack-plugin do
        searchResolveModulesDirectories: false
  resolve: # options for resolving module
    alias: # module alias
      jquery: \jquery/dist/jquery.min.js
      moment: \moment/moment.js
      react: \react/dist/react.min.js
      react-dom: \react-dom/dist/react-dom.js
    modules-directories: <[app node_modules]> # directories that webpack search for modules
  stylus: # stylus loader config. ref: https://github.com/shama/stylus-loader
    import: <[~nib/lib/nib/index.styl]>
    use: [nib!]

# vi:et:nowrap:sw=2:ts=2
