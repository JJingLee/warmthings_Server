var rootDir = __dirname.substr(0, __dirname.indexOf('APIs'));

// modules
exports.RootDir = rootDir;
exports.HTTPModule = require(rootDir + '/network_model/http');

