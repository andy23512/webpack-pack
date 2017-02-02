# Description
It's a start pack for webpack + express.
Some explaination or references are shown in comments above the corresponding settings or solutions.

# What's in this pack
  * tool
    * webpack 2
    * gulp
  * preprocessor
  	* pug
    * stylus
    * LiveScript
  * webserver
  	* express with webpack hot middleware and webpack dev middleware
    * webpack-dev-server
  * frontend module
    * jQuery
    * semantic-ui-css

# setup
  * mkdir option/
  * cd option/
  * echo [your port number] > port
  * echo [your host name or ip] > host
  * cd ..
  * yarn (or npm i)

# command

## run express + webpack middlewares
  * yarn start (or npm start)


## run webpack-dev-tool
  * yarn run dev (or npm run dev) # if you don't want to invoke gulp (pure front-end)

## build bundle files to disk
  * yarn run build (or npm run build)
