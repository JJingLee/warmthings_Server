var https       = require('https');
var app         = require('express')();
var bodyParser  = require('body-parser');
var multer      = require('multer');
var upload      = multer();
var ssl         = require('./sslLicence');
var port        = 9988;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true}));

var Post = function(route, callback){
    
    app.post(''+route, upload.array(),function(req,res){
        console.log('post come.')
        callback(req, res);
    }).on('error', function(e){
        console.log("error :"+e.message);
    });

    

};

var httpsServer = https.createServer(ssl.options, app).listen(port);

//Exports modules
exports.POST = Post;