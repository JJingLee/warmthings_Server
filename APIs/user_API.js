var API = require('./API_global')

function user_API(req, res){
	console.log('user api.');
    res.send('user api.');
    console.log(process.exit());
}

module.exports = {
	method: 'GET',
	route : '/user',
	callback : user_API
}