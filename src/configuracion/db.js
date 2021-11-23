const sequelize = require('sequelize');
const db = new sequelize(
    'bd_techno_factory',
    'root',
    'luis1234',
    {
        host: '127.0.0.1',
        dialect: 'mysql',
        port: '3306'
    }
);
module.exports= db;