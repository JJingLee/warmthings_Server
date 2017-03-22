var mysql      = require('mysql');
var path = require('path');
var fs = require('fs');
var prop = require('properties-parser');
var properties = prop.read(path.join(__dirname, './mysql.conf'));

var connection = mysql.createConnection({
	host : properties.host,
	user : properties.user,
	password : properties.password,
	database : properties.database
});

connection.connect(function(err){
	if(err){
		console.log(err);
		console.log('db connected failed.')
		return;
	} 
	console.log('db connected.')
});

exports.MySQLConn = connection;

