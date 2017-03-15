var fs = require('fs');

//ssl license

var keyPath = 'network_model/ssl/key.pem';
var certPath = 'network_model/ssl/cert.pem';

var hskey = fs.readFileSync(keyPath);
var hscert = fs.readFileSync(certPath);

var options = {
    key: hskey,
    cert: hscert
};

//ssl object

var ssl = {};

ssl.options = options;

module.exports = ssl;
