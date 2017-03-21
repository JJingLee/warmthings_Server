var APIGlobals = require('./API_global');
var dev_route = '/developer';
var childProcess = require('child_process').exec;


exports.serverReboot = APIGlobals.HTTPModule.POST(dev_route+'/reboot',function(req, res){
    console.log('-------- will do reboot ------');
    childProcess(' . ' + APIGlobals.RootDir + '/shutdown_server.sh',function(err,stdout,stderr){
        console.log('reboot error : ' + err);
        console.log('reboot stdout : ' + stdout);
    })
    res.send('server is doing reboot.');
})