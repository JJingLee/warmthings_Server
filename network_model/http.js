var https       = require('https');
var debug = require('debug')('warmthing:httpsServer');
var app         = require('express')();
var bodyParser  = require('body-parser');
var multer      = require('multer');
var upload      = multer();
var ssl         = require('./sslLicence');
var httpsPort   = 9988;
var httpsServer;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true}));

var Post = function(route, callback){
    app.post(''+route, upload.array(),function(req,res){
        console.log('post come.');
        callback(req, res);
    }).on('error', function(e){
        console.log("error :"+e.message);
    });
};

var Get = function(route, callback){
	app.get(route, function(req, res){
		console.log('get come');
		callback(req, res);
	});
}

//For apis route
var routeBuilder = function(){
	this.apis = [];
	this.build = build;
	this.add = function(api){
		this.apis.push(api);
	};
}

function build(){
	if(this.apis)
		for( idx in this.apis){
			switch (this.apis[idx].method){
			case 'GET':
				app.get(this.apis[idx].route, this.apis[idx].callback);
				break;
			case 'POST':
				app.post(this.apis[idx].route, upload.array() , this.apis[idx].callback);
				break;
			case 'PUT':
				app.put(this.apis[idx].route, this.apis[idx].callback);
				break;
			}

			console.log('API build: ' + this.apis[idx].method + ' ' + this.apis[idx].route);
		}
}

function run(){
	httpsServer = https.createServer(ssl.options, app);
	initWebServer(httpsServer, httpsPort);
}


function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    return val;
  }

  if (port >= 0) {
    return port;
  }

  return false;
}

function initWebServer(wserver, port) {
  function onError(error) {
    if (error.syscall !== 'listen') {
      throw error;
    }

    var bind = typeof port === 'string'
    ? 'Pipe ' + port
    : 'Port ' + port;

    switch (error.code) {
      case 'EACCES':
      console.error(bind + ' requires elevated privileges');
      process.exit(1);
      break;
      case 'EADDRINUSE':
      console.error(bind + ' is already in use');
      process.exit(1);
      break;
      default:
      throw error;
    }
  }

  function onListening() {
    var addr = wserver.address();
    var bind = typeof addr === 'string'
    ? 'pipe ' + addr
    : 'port ' + addr.port;
    debug('Listening on ' + bind);
  }
  wserver.listen(port);
  wserver.on('error', onError);
  wserver.on('listening', onListening);
}

//Exports modules
module.exports = {
	//server action
	run:run,

	//method
	POST:Post,
	GET:Get,

	//Tool
	RouteBuilder:routeBuilder
}