var user_DAO = require('../db_model/user_DAO')


function create_user(req, res, next){
	var userObj = req.body;
	
	user_DAO.create_user(userObj, function(err, result){
		if(err){
			console.log(err);
			res.send('create user failed!');
		}else{
			console.log(result);
			res.send(result);
		}
	});

}


module.exports = {
	method: 'POST',
	route: '/user',
	callback: create_user
}