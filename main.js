var apiGlobal = require('./APIs/API_global')
var routeBuilder = new apiGlobal.HTTPModule.RouteBuilder();

//For extending api
routeBuilder.add(require('./APIs/testAPI'));
routeBuilder.add(require('./APIs/user_API'));


//build after api config completely
routeBuilder.build();

apiGlobal.HTTPModule.run();

// Developer Commands
// var commands = require('./APIs/developer_commands_API');
// commands.serverReboot;

//mysql query demo
// var mysqlHandler = require('./mysql_module/mysqlHandler');
// var warmdb_CRM_DB = new mysqlHandler.connect('127.0.0.1','root','12345678','warmdb_CRM');
// warmdb_CRM_DB.query('SELECT * FROM user_member');