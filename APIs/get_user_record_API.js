function get_user_record(req, res){
	console.log('user record api.');
    console.log(req.params.userid);
    // console.log(process.exit());
}

module.exports = {
	method: 'GET',
	route : '/user/:userid/record',
	callback : get_user_record
}