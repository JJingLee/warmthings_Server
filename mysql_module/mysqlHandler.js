var mysql = require('mysql');


var connect_to_mysq_server = function(myHost,myUser,myPassword,myDatabase){
    this.connection = mysql.createConnection({
        host:myHost,
        user:myUser,
        password:myPassword,
        database:myDatabase
    });
    this.query = queryWithString;
};

var queryWithString = function(queryString)
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
    //start query
    this.connection.query(queryString+'', function(err,rows) {
        if (err) throw err;
        console.log(rows);
    })
    this.connection.end();
};



module.exports = {
    connect:connect_to_mysq_server
};