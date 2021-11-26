
const ModeloClientes = require('../modelos/modeloCliente');

exports.ListaClientes = async (req, res) => {
   // var mensaje = "Bienvenido al sistema";
   const ListarClientes = await ModeloClientes.findAll();
   var mensaje =
   {
      texto: "Hola",
      codigo: 1
   };
   //  res.json(ListarClientes);

   res.render('Clientes', { ListarClientes });
};


//Guardar
exports.Guardar = async (req, res) => {

   const { txtDni, txtNombre, txtApellido, cmbGenero, cmbFecha, cmbEstado } = req.body;
   var ListarClientes = await ModeloClientes.findAll();
   if (!txtDni || !txtNombre || !txtApellido || !cmbGenero || !cmbFecha || !cmbEstado) {
      res.render('Clientes', {
         msg: "",
         error: "",
         advertencia:"Advertencia",
         mensaje:"Todos los campos son Obligatorio",
         ListarClientes 
      });
   }
   else {
      // res.send("Aqui");
     // req.flash('success', 'You are successfully using req-flash');
      //res.render('Clientes', { msg: "", error: "Error", ListarClientes });
      //console.log("Todos los campos son obligatorios 2");
      
      const BuscarCliente = await ModeloClientes.findOne({
         where: {
            dni: txtDni
         }
      });

      if (BuscarCliente) {

         console.log("El cliente ya existe");
         res.render('Clientes', {
            msg: "",
            error: "",
            advertencia:"Advertencia",
            mensaje:"El cliente ya existe",
            ListarClientes 
         });
     //    res.send("El cliente ya existe");
        
      }
      else {
         var estado = true;
       
         await ModeloClientes.create({
            "dni":txtDni,
            "nombreCliente":txtNombre,
            "apellidoCliente":txtApellido,
            "genero":cmbGenero,
            "fechaNacimiento":cmbFecha,
            "idEstado":cmbEstado,
            "isActivo":estado
         })
            .then((data) => {
               console.log(data);
               var info = ("El Cliente: " + data.dataValues.nombreCliente + " " + data.dataValues.apellidoCliente + " se registro con éxito");
               res.render('Clientes', {
                  msg: "Datos Correctos",
                  error: "",
                  advertencia:"",
                  mensaje:info,
                  ListarClientes 
               });
            })
            .catch((error) => {
               console.log(error);
               var info = "no se pudo guardar";
               res.render('Clientes', {
                  msg: "",
                  error: "Error",
                  advertencia:"",
                  mensaje:info,
                  ListarClientes 
               });
            });
         //   console.log(req.body);

      }

   }


};

exports.Eliminar = async (req, res) => {
   const { id } = req.query;
   if (!id) {
      console.log("Envie el id del cliente");
      res.send("Envie el id del cliente");
   }
   else {
      const BuscarCliente = await ModeloClientes.findOne({
         where: {
            idCliente: id
         }
      });

      if (!BuscarCliente) {
         res.send("El Cliente no existe");
         console.log("El Cliente no existe");
      }
      else {
         await BuscarCliente.destroy()
            .then((data) => {
               console.log(data.dataValues);
               res.send("El regisitro se ha eliminado " + data.dataValues.nombreCliente);
            })
            .catch((error) => {
               console.log(error);
            });
      }
   }


};

exports.Modificar = async (req, res) => {
   const { id } = req.query;
   const { dni, nombreCliente, apellidoCliente, genero, fechaNacimiento, idEstado } = req.body;


   if (!id || !dni || !nombreCliente || !apellidoCliente || !genero || !fechaNacimiento || !idEstado) {
      console.log(req.body);
      res.send("Todos los campos son obligatorios");
      console.log("Todos los campos son obligatorios");
   }
   else {
      const BuscarCliente = await ModeloClientes.findOne({
         where: {
            idCliente: id
         }
      });

      if (!BuscarCliente) {
         res.send("El cliente no existe");
         console.log("El cliente no existe");
      }
      else {
         BuscarCliente.dni = dni;
         BuscarCliente.nombreCliente = nombreCliente;
         BuscarCliente.apellidoCliente = apellidoCliente;
         BuscarCliente.genero = genero;
         BuscarCliente.fechaNacimiento = fechaNacimiento;
         BuscarCliente.idEstado = idEstado;


         await BuscarCliente.save()
            .then((data) => {
               console.log(data);
               res.send("El Cliente se actualizo");
            })
            .catch((error) => {
               console.log(error);
               res.send("no se pudo guardar");
            });
         //   console.log(req.body);

      }

   }


};