var apiMgr = reuqire('API_manager')

apiMgr.HTTPModule.GET('/findExt', function(req, res){
	console.log(req);
});