const sequelize = require('sequelize');
const db = require('../configuracion/db');
const bcrypt = require('bcrypt');
const Modelos = db.define(

    "modelo",
    {
        idModelo: {
                type: sequelize.INTEGER,
                primaryKey: true,
                autoIncrement:true,
                allowNull: false
        },
        descripcionModelo:{
            type: sequelize.STRING(50),
            allowNull: false
        },
        idMarca:{
            type: sequelize.INTEGER,
            allowNull: true
        },
        idEstado:{
            type: sequelize.INTEGER,
            allowNull: true
        },
        isActivo:{
            type: sequelize.BOOLEAN,
            allowNull: false
        }
       
    },
    {
        tableName: "Modelos",
        timestamps:false
        
        
    }
);

module.exports = Modelos;