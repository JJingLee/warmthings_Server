var apiGlobal = require('./APIs/API_global')
var routeBuilder = new apiGlobal.HTTPModule.RouteBuilder();

//For extending api
routeBuilder.add(require('./APIs/test_API'));
routeBuilder.add(require('./APIs/create_user_API'));
routeBuilder.add(require('./APIs/create_user_record_API'));
routeBuilder.add(require('./APIs/get_user_API'));
routeBuilder.add(require('./APIs/get_user_record_API'));


//build after api config completely
routeBuilder.build();

apiGlobal.HTTPModule.run();

// Developer Commands
// var commands = require('./APIs/developer_commands_API');
// commands.serverReboot;

// mysql query demo
var mysqlHandler = require('./mysql_module/mysqlHandler');
var warmdb_CRM_DB = new mysqlHandler.connect('127.0.0.1','noah','Abcd1234','warmdb_CRM');
warmdb_CRM_DB.query('SELECT * FROM user_member');