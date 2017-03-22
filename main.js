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


// process.on('exit', function(code) {
// 	apiGlobal.HTTPModule.run();
// 	console.log('run server again');
// });


// var test = require('./APIs/testAPI')
// test.Test_Post;

// Developer Commands
// var commands = require('./APIs/developer_commands_API');
// commands.serverReboot;