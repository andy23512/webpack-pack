# Description
It's a start pack for webpack + express.
Some explaination or references are shown in comments above the corresponding settings or solutions.

# What's in this pack
  * tool
	* webpack
	* gulp
	* bower
  * preprocessor
  	* pug
	* stylus
	* LiveScript
  * webserver
  	* express with webpack hot middleware and webpack dev middleware
	* webpack-dev-server
  * frontend module
    * jQuery
	* semantic-ui

# setup
  * mkdir option/
  * cd option/
  * echo [your port number] > port
  * echo [your host name or ip] > host
  * cd ..
  * npm i

# command
## run express + webpack middlewares
  * npm start
## run webpack-dev-tool
  * npm run dev # if you don't want to invoke gulp (pure front-end)
## build bundle files to disk
  * npm run build
