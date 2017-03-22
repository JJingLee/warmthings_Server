function create_user_record(){
	console.log('create user record!');
	res.send('create user record!');
}


module.exports = {
	method: 'POST',
	route : '/user/:userid/record',
	callback : create_user_record
}