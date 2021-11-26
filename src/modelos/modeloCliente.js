const sequelize = require('sequelize');
const db = require('../configuracion/db');
const bcrypt = require('bcrypt');
const Clientes = db.define(

    "cliente",
    {
        idCliente: {
                type: sequelize.INTEGER,
                primaryKey: true,
                autoIncrement:true,
                allowNull: false
        },
        dni:{
            type: sequelize.STRING(13),
            allowNull: false
        },
        nombreCliente:{
            type: sequelize.STRING(50),
            allowNull: false
        },
        apellidoCliente:{
            type: sequelize.STRING(50),
            allowNull: false
        },
        genero:{
            type: sequelize.STRING(30),
            allowNull: false
        },
        fechaNacimiento:{
            type: sequelize.DATE,
            allowNull: false
        },
        
        idEstado:{
            type: sequelize.INTEGER,
            allowNull: false
        },
        isActivo:{
            type: sequelize.BOOLEAN,
            allowNull: false
        },
    },
    {
        tableName: "Clientes",
        timestamps:false
        
        
    }
);
module.exports = Clientes;