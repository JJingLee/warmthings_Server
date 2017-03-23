var mysqlHandler = require('./mysqlHandler');

//JJing home warmdb_CRM db 
exports.warmdb_CRM_JJTest = new mysqlHandler.connect('127.0.0.1','root','12345678','warmdb_CRM');
