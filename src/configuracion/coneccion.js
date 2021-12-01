var mysql = require('mysql2');

const con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "luis1234",
  database: "bd_techno_factory"
});

module.exports=con;