var https       = require('https');
var app         = require('express')();
var bodyParser  = require('body-parser');
var multer      = require('multer');
var upload      = multer();
var ssl         = require('./sslLicence');
var port        = 9988;
var httpsServer = https;

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
	httpsServer.createServer(ssl.options, app).listen(port);
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