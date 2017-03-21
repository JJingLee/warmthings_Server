var APIGlobal  = require('./API_global');

// exports.Test_Post = APIGlobal.HTTPModule.POST('/test',function(req, res){
//     console.log('into test.');
//     res.send('test received got.');
// });

function test_post(req, res){
	console.log('into test.');
    res.send('test received got.');
}

module.exports = {
	method: 'POST',
	route: '/test',
	callback: test_post
}
