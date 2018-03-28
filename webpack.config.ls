require! <[html-webpack-plugin nib webpack ./opt.ls]>

# ref: https://webpack.js.org/configuration/
module.exports =
  dev-server: # ref: https://webpack.js.org/configuration/dev-server/
    # content-base: folder that dev-server serve the file from
    content-base: \dist
    # host setting
    host: \0.0.0.0
    # inline mode (watch and build)
    inline: true
    hot: true
    port: opt.port
  # entry: entry point of the bundle
  entry: <[./app/app.ls]>
  # context: base directories for entry
  context: __dirname
  module:
    rules: # https://webpack.js.org/configuration/module/#module-rules
      * test: /\.(jade|pug)$/ use: \pug-loader # test: match files, use: applied loader to the matched files
      * test: /\.jsx?$/ exclude: /\/node_modules\// use: \babel-loader
      * test: /\.ls$/ use: \livescript-loader
      * test: /\/res\/image\// use: loader: \url-loader options: limit: 10000
      * test: /\.styl$/ use: <[style-loader css-loader stylus-loader]>
      * test: /\.css$/ use: <[style-loader css-loader]>
      * test: /\.(eot|ico|jpg|mp3|svg|ttf|woff2|woff|png?)($|\?)/ use: \file-loader
  output:
    filename: \app.js # output single js file
    path: __dirname + \/dist # output path
    public-path: "//#{opt.host}:#{opt.port}/" # required when used with express, ref: https://webpack.github.io/docs/webpack-dev-server.html#combining-with-an-existing-server
  plugins: # Additional plugins. ref: https://webpack.js.org/plugins/
    # Enables Hot Module Replacement
    * new webpack.HotModuleReplacementPlugin!
    # Stop compilation when there's any error or warning
    * new webpack.NoEmitOnErrorsPlugin!
    # Automatically loaded modules. The keys are as variables corresponding to the modules.
    * new webpack.Provide-plugin $: \jquery jQuery: \jquery app: \app.ls
    # Generate html file. ref: https://www.npmjs.com/package/html-webpack-plugin
    * new html-webpack-plugin do
        # favicon: \app/res/image/favicon.ico
        # inject: place to inject all assets
        inject: \body
        # template: path to template
        template: \app/index.pug
    # stylus loader config. ref: https://github.com/shama/stylus-loader
    * new webpack.LoaderOptionsPlugin do
        test: /\.styl$/
        stylus: default: import: <[~nib/lib/nib/index.styl]>, use: [nib!]
  resolve: # options for resolving module
    alias: # module alias
      jquery: \jquery/dist/jquery.min.js
    modules: <[app node_modules]> # directories that webpack search for modules

# vi:et:nowrap:sw=2:ts=2
