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
            res.render('Productos', 
            { 
                ListarCategorias,
                ListarModelos,
                title: "TechniFactory | Productos", ListaProductos });
        });
    });
};

exports.FormProducto = async (req, res) => {
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
            res.render('VistaProductos/FormProducto', 
            { 
                ListarCategorias,
                ListarModelos,
                title: "Productos", ListaProductos });
        });
    });
};

exports.Guardar_Y_Modificar = async (req, res) => {
    var mensaje = "";
    const { 
        id,
        txtNombre,
        txtCantidad,
        cmbCategoria,
        cmbEstado,
        txtPrecioE,
        txtPrecioV,
        cmbModelo,
        txtDescripcion,
        btnAccion    
    } = req.body;


    if(btnAccion == "guardar")
    {
        var sql = "call bd_techno_factory.AccionesProductos('G', 0, ?, ?, ?, ?, ?, ?, ?, ?);";
        con.connect(function (err) {
           if (err) throw err;
           con.query(sql,[txtNombre,txtDescripcion,txtCantidad,cmbCategoria,cmbEstado,txtPrecioE,txtPrecioV,cmbModelo], function (err, result) {
               if (err) throw err;
               console.log(result[0][0]);
               
               mensaje = result[0][0];
               //console.log(Lista);
               res.render('VistaProductos/FormProducto', {  title: "Productos", mensaje });
           });
       });
    }
    else
    {
        /*
        var sql = "call bd_techno_factory.AccionesClientes('0', 'G', ?, ?, ?, ?, ?, ?);";
        con.connect(function (err) {
           if (err) throw err;
           con.query(sql,[txtDni,txtNombre,txtApellido,cmbGenero,cmbFecha,cmbEstado], function (err, result) {
               if (err) throw err;
               console.log(result[0][0]);
               
               mensaje = result[0][0];
               //console.log(Lista);
               res.render('VistaClientes/Clientes', {  title: "Clientes", mensaje });
           });
       });
       */
    }

 };