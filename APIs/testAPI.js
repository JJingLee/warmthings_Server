var APIGlobal  = require('./API_global');
var warm_CRM_DB = APIGlobal.DB.warmdb_CRM_JJTest;
function test_post(req, res){

	//DB demo.
	warm_CRM_DB.query('SELECT * FROM user_member', function(result){
		//db query result.
		res.send('result = ' + JSON.stringify(result,null,1));
	});
    
}

//http config demo, add in main.js
module.exports = {
	method: 'POST',
	route: '/test',
	callback: test_post
}
