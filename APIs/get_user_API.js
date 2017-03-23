var user_DAO = require('../db_model/user_DAO')

function get_user(req, res){
		user_DAO.get_user_by_id(
			req.params.userid == 'all'?'all': req.params.userid, 
				function(err, rows){
			if(err){
				console.log(req.url + ': DB failed');
				return res.send('DB failed');
			}else{
				// console.log(rows);
				res.json(rows);
			}
		});
}

function isEmailValid(){
	
}

module.exports = {
	method: 'GET',
	route : '/user/:userid',
	callback : get_user
}