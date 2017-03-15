var APIGlobal  = require('./API_global');

exports.Test_Post = APIGlobal.HTTPModule.POST('/test',function(req, res){
    console.log('into test.');
    res.send('test received got.');
});
