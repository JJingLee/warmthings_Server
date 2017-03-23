var mysql = require('mysql');


var connect_to_mysq_server = function(myHost,myUser,myPassword,myDatabase){
    this.connection = mysql.createConnection({
        host:myHost,
        user:myUser,
        password:myPassword,
        database:myDatabase
    });

    this.startConnection = startConnection;
    
    this.query = queryWithString;
    
    this.end = function(){
        this.connect.end();
    }
};


var startConnection = function()
{
    if (typeof this.connection === undefined)
    {
        console.log('no connection with db');
        return;
    }
    //connect to db
    this.connection.connect(function(err){
        if(err) throw error;
        console.log('db client success');
    });
};

var queryWithString = function(queryString, callback)
{
    //start query
    this.connection.query(queryString+'', function(err,rows) {
        if (err) throw err;
        console.log(rows);
        callback(rows);
    })
};



module.exports = {
    connect:connect_to_mysq_server
};