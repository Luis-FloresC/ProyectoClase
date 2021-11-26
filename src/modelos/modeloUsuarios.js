const sequelize = require('sequelize');
const db = require('../configuracion/db');
const bcrypt = require('bcrypt');
const Usuarios = db.define(

    "usuarios",
    {
        idUsuario: {
                type: sequelize.INTEGER,
                primaryKey: true,
                autoIncrement:true,
                allowNull: false
        },
        nombreUsuario:{
            type: sequelize.STRING(50),
            allowNull: true
        },
        contrasenia:{
            type: sequelize.STRING(50),
            allowNull: true
        },
        idCargo:{
            type: sequelize.INTEGER,
            allowNull: true
        },
        correoElectronico:{
            type: sequelize.STRING(100),
            allowNull: true
        },
        idEmpleado:{
            type: sequelize.INTEGER,
            allowNull: true
        },
        
        idCliente:{
            type: sequelize.INTEGER,
            allowNull: true
        },
        isEmpleado:{
            type: sequelize.BOOLEAN,
            allowNull: true
        },
    },
    {
        tableName: "Usuarios",
        timestamps:false
        
        
    }
);

module.exports = Usuarios;