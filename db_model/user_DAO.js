var con = require('./mysql').MySQLConn;
const SELECT_ALL_USER= 'SELECT * from user_member'
const SELECT_USER_BY_ID = 'SELECT * from user_member WHERE id=';
const INSERT_USER_MEMBER = 'INSERT INTO user_member SET ?';

function get_user_by_id(id, callback){
	if(id == 'all'){
		con.query( SELECT_ALL_USER , function(err, rows, fields){
			callback(err, rows);
		});
	}else if(id){
		con.query( SELECT_USER_BY_ID + id, function(err, rows, fields){
			callback(err, rows);
		});
	}
	else{
		callback('get_user_by_id: error');
	}
}

function create_user(userObj, callback){
	// var values = [];
	// var valuesKey = [
	// 	'id',
	// 	'name',
	// 	'password',
	// 	'eamil',
	// 	'type',
	// 	'birth',
	// 	'blood',
	// 	'address',
	// 	'default_delivery_address',
	// 	'tel',
	// 	'mobile',
	// 	'des',
	// 	'current_used_goods_list',
	// 	'enable',
	// 	'login_time',
	// 	'create_time'
	// ];


	// for(value in valuesKey)
	// 	values.push(userObj[value]);
	con.query( INSERT_USER_MEMBER, userObj, function(err, result){
		callback(err, result);
	});
}

module.exports = {
	get_user_by_id : get_user_by_id,
	create_user : create_user,
}