const ModeloProducto = require('../modelos/modeloProductos');
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
        con.query("call bd_techno_factory.ListarProductos2();", function (err, result, fields) {
            if (err) throw err;
            ListaProductos = result[0];
            //console.log(Lista);
            res.render('VistaProductos/ListarProductos',
                {
                    ListarCategorias,
                    ListarModelos,
                    title: "Productos", ListaProductos
                });
        });
    });
};

exports.Listar = async (req, res) => {
    // var mensaje = "Bienvenido al sistema";
    const ListarCategorias = await ModeloCategorias.findAll();
    const ListarModelos = await ModeloModelo.findAll();

    var ListaProductos = [];
    //Funcion para ejecutar un proceso almacenado
    con.connect(function (err) {
        if (err) throw err;
        con.query("call bd_techno_factory.ListarProductos2();", function (err, result, fields) {
            if (err) throw err;
            ListaProductos = result[0];
            //console.log(Lista);
            res.json(ListaProductos);
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
        con.query("call bd_techno_factory.ListarProductos2();", function (err, result, fields) {
            if (err) throw err;
            ListaProductos = result[0];
            //console.log(Lista);
            res.render('VistaProductos/FormProducto',
                {
                    ListarCategorias,
                    ListarModelos,
                    valor: "guardar",
                    title: "Productos", ListaProductos
                });
        });
    });
};

exports.Guardar_Y_Modificar = async (req, res) => {
    const ListarCategorias = await ModeloCategorias.findAll();
    const ListarModelos = await ModeloModelo.findAll();
    var ListaProductos = [];
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


    if (btnAccion == "guardar") {
        var sql = "call bd_techno_factory.AccionesProductos('G', 0, ?, ?, ?, ?, ?, ?, ?, ?);";
        con.connect(function (err) {
            if (err) throw err;
            con.query(sql, [txtNombre, txtDescripcion, txtCantidad, cmbCategoria, cmbEstado, txtPrecioE, txtPrecioV, cmbModelo], function (err, result) {
                if (err) throw err;
                console.log(result[0][0]);

                mensaje = result[0][0];
                //console.log(Lista);
                res.render('VistaProductos/FormProducto', { title: "Productos", mensaje, ListarModelos, ListarCategorias });
            });
        });
    }
    else {

        var sql = "call bd_techno_factory.AccionesProductos('M', ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        con.connect(function (err) {
            if (err) throw err;
            con.query(sql, [id, txtNombre, txtDescripcion, txtCantidad, cmbCategoria, cmbEstado, txtPrecioE, txtPrecioV, cmbModelo], function (err, result) {
                if (err) throw err;
                console.log(result[0][0]);

                mensaje = result[0][0];
                //console.log(Lista);

            });
        });

        // var mensaje = "Bienvenido al sistema";



        //Funcion para ejecutar un proceso almacenado
        con.connect(function (err) {
            if (err) throw err;
            con.query("call bd_techno_factory.ListarProductos2();", function (err, result, fields) {
                if (err) throw err;
                ListaProductos = result[0];
                //console.log(Lista);
                res.render('VistaProductos/ListarProductos',
                    {
                        ListarCategorias,
                        ListarModelos,
                        title: "Productos", ListaProductos
                    });
            });
        });
    }

};

exports.cargarDatos = async (req, res) => {

    const { id } = req.params;

    const ListarCategorias = await ModeloCategorias.findAll();
    const ListarModelos = await ModeloModelo.findAll();
    const BuscarProducto = await ModeloProducto.findOne({
        where: {
            idProducto: id
        }
    });

    res.render('VistaProductos/FormProducto', {
        title: "Productos",
        valor: "Modificar",
        BuscarProducto,
        ListarCategorias,
        ListarModelos
    });

};

exports.Eliminar = async (req, res) => {

    const { id } = req.params;
    const ListarCategorias = await ModeloCategorias.findAll();
    const ListarModelos = await ModeloModelo.findAll();
    console.log("id: ", id);



    var mensaje = "";
    var sql = "UPDATE productos SET idEstado = 2 WHERE idProducto=?";
    con.connect(function (err) {
        if (err) throw err;
        con.query(sql, [id], function (err, result) {
            if (err) throw err;
            console.log(result);

            mensaje = result;
            //console.log(Lista);

        });
    });

    var ListaProductos = [];
    //Funcion para ejecutar un proceso almacenado
    con.connect(function (err) {
        if (err) throw err;
        con.query("call bd_techno_factory.ListarProductos2();", function (err, result, fields) {
            if (err) throw err;
            ListaProductos = result[0];
            //console.log(Lista);
            res.render('VistaProductos/ListarProductos',
                {
                    ListarCategorias,
                    ListarModelos,
                    title: "Productos", ListaProductos
                });
        });
    });

};