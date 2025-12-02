let mysql = require('mysql2');

const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'classmysql.engr.oregonstate.edu',
  user: 'cs340_hajjm',    
  password: '3680',        
  database: 'cs340_hajjm'
}).promise();

module.exports = pool;

