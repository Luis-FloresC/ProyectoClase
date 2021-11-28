const ModeloProducto = require('../modelos/modeloUsuarios');
const ModeloCategorias = require('../modelos/modeloCategorias');
const ModeloModelo = require('../modelos/modeloModelos');
const sequelize = require('sequelize');
const con = require('../configuracion/coneccion');
//Metodo para Listar Productos
exports.ListarProductos = async (req, res) => {
    // var mensaje = "Bienvenido al sistema";
    const ListarCategorias = await ModeloCategorias.findAll();
    const ListarModelos = await ModeloModelo.findAll();

    var ListaProductos = [];
    //Funcion para ejecutar un proceso almacenado
    con.connect(function (err) {
        if (err) throw err;
        con.query("call bd_techno_factory.ListarProductos();", function (err, result, fields) {
            if (err) throw err;
            ListaProductos = result[0];
            //console.log(Lista);
            res.render('Productos', { ListarCategorias, ListarModelos, title: "TechniFactory | Productos", ListaProductos });
        });
    });
};
