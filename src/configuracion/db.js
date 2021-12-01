const sequelize = require('sequelize');
const db = new sequelize(
    'bd_techno_factory',
    'root',
    'luis1234',
    {
        host: 'localhost',
        dialect: 'mysql',
        port: '3306'
    }
);




module.exports= db;
