var rootDir = __dirname.substr(0, __dirname.indexOf('APIs'));
var HTTPModule = require(rootDir + '/network_model/http');
var DBPool = require('../mysql_module/DBPool');

// modules
exports.RootDir = rootDir;
exports.HTTPModule = HTTPModule;
exports.DB = DBPool; 
