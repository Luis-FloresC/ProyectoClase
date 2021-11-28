const sequelize = require('sequelize');
const db = require('../configuracion/db');
const bcrypt = require('bcrypt');
const Categorias = db.define(

    "categoria",
    {
        idCategoria: {
                type: sequelize.INTEGER,
                primaryKey: true,
                autoIncrement:true,
                allowNull: false
        },
        descripcionCategoria:{
            type: sequelize.STRING(50),
            allowNull: false
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
        tableName: "Categorias",
        timestamps:false
        
        
    }
);

module.exports = Categorias;