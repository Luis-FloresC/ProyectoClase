var mysql = require('mysql2');

const con = mysql.createConnection({
  host: "192.168.100.21",
  user: "luis",
  password: "luis1234",
  database: "bd_techno_factory"
});

module.exports=con;