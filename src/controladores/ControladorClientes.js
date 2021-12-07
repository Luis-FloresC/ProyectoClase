
const ModeloClientes = require('../modelos/modeloCliente');
const con = require('../configuracion/coneccion');

exports.ListaClientes = async (req, res) => {
   // var mensaje = "Bienvenido al sistema";
   var ListaClientes = [];
   //Funcion para ejecutar un proceso almacenado
   con.connect(function (err) {
       if (err) throw err;
       con.query("call bd_techno_factory.ListarClientes();", function (err, result, fields) {
           if (err) throw err;
           ListaClientes = result[0];
           //console.log(Lista);
           res.render('VistaClientes/Clientes', {  title: "Clientes", ListaClientes,id:2 });
       });
   });
};

exports.Modificar = async (req, res) => {

   const { id, txtDni, txtNombre, txtApellido, cmbGenero, cmbFecha, cmbEstado } = req.body;
   var mensaje = "";
   console.log(req.body);
   
   var sql = "call bd_techno_factory.AccionesClientes(?, 'M', ?, ?, ?, ?, ?, ?);";
   con.connect(function (err) {
      if (err) throw err;
      con.query(sql,[id,txtDni,txtNombre,txtApellido,cmbGenero,cmbFecha,cmbEstado], function (err, result) {
          if (err) throw err;
          console.log(result[0][0]);
          
          mensaje = result[0][0];
          //console.log(Lista);
          res.render('VistaClientes/Clientes', {  title: "Clientes", mensaje });
      });
  });

  

};

exports.Lista2 = async (req, res) => {
   var ListaClientes = [];
   //Funcion para ejecutar un proceso almacenado
   con.connect(function (err) {
       if (err) throw err;
       con.query("call bd_techno_factory.ListarClientes();", function (err, result, fields) {
           if (err) throw err;
           ListaClientes = result[0];
           //console.log(Lista);
           res.render('VistaClientes/ListarClientes', {  title: "Clientes", ListaClientes });
       });
   });
};


//Guardar
exports.Guardar = async (req, res) => {

   const { txtDni, txtNombre, txtApellido, cmbGenero, cmbFecha, cmbEstado } = req.body;
   var mensaje = "";
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

};



exports.Eliminar = async (req, res) => {

   const { id } = req.params;
   
   console.log("id: ",id);
   


   var mensaje = "";
   var sql = "UPDATE Clientes SET idEstado = 2 WHERE idCliente=?";
   con.connect(function (err) {
      if (err) throw err;
      con.query(sql,[id], function (err, result) {
          if (err) throw err;
          console.log(result);
          
          mensaje = result;
          //console.log(Lista);
          
      });
  });

  var ListaClientes = [];
  //Funcion para ejecutar un proceso almacenado
  con.connect(function (err) {
      if (err) throw err;
      con.query("call bd_techno_factory.ListarClientes();", function (err, result, fields) {
          if (err) throw err;
          ListaClientes = result[0];
          //console.log(Lista);
          res.render('VistaClientes/ListarClientes', {  title: "Clientes", ListaClientes });
      });
  });

};

exports.cargarDatos = async (req, res) => {

   const { id } = req.params;
   
   const BuscarCliente = await ModeloClientes.findOne({
      where: {
         idCliente: id
      }
   });
   console.log("Cliente: ",BuscarCliente);
   res.render('VistaClientes/ClientesEditar', {  title: "Actualizar Clientes",BuscarCliente });

};