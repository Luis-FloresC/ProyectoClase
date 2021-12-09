const sequelize = require('sequelize');
const db = require('../configuracion/db');
const bcrypt = require('bcrypt');
const Productos = db.define(

    "producto",
    {
        idProducto: {
                type: sequelize.INTEGER,
                primaryKey: true,
                autoIncrement:true,
                allowNull: false
        },
        nombreProducto:{
            type: sequelize.STRING(50),
            allowNull: false
        },
        descripcionProducto:{
            type: sequelize.STRING(2000),
            allowNull: false
        },
        cantidadExistencia:{
            type: sequelize.INTEGER,
            allowNull: false
        },
        idCategoria:{
            type: sequelize.INTEGER,
            allowNull: true
        },
        idEstado:{
            type: sequelize.INTEGER,
            allowNull: false
        },        
        precioEstandar:{
            type: sequelize.DECIMAL,
            allowNull: false
        },
        precioVenta:{
            type: sequelize.DECIMAL,
            allowNull: false
        },
        idModelo:{
            type: sequelize.INTEGER,
            allowNull: true
        }, 
    },
    {
        tableName: "productos",
        timestamps:false
        
        
    }
);
module.exports = Productos;