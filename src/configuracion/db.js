const sequelize = require('sequelize');
const db = new sequelize(
    'bd_techno_factory',
    'luis',
    'luis1234',
    {
        host: '192.168.100.21',
        dialect: 'mysql',
        port: '3306'
    }
);
module.exports= db;