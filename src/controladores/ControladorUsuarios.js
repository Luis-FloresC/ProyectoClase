const ModeloClientes = require('../modelos/modeloCliente');

exports.ListaClientes = async (req,res)=>
{
      // var mensaje = "Bienvenido al sistema";
      const ListarClientes = await ModeloClientes.findAll();
       var mensaje = 
       {
          texto: "Hola",
          codigo:1
       };
       res.json(ListarClientes);
};

//Guardar
exports.Guardar = async (req,res) =>
{
   const { dni, nombreCliente, apellidoCliente, genero, fechaNacimiento, idEstado } = req.body;
 

 if(!dni || !nombreCliente || !apellidoCliente || !genero || !fechaNacimiento || !idEstado)
 {
    console.log(req.body);
    res.send("Todos los campos son obligatorios");
    console.log("Todos los campos son obligatorios");
 }
 else
 {
   const BuscarCliente = await ModeloClientes.findOne({
         where:{
            dni: dni
         }
      });
  
   if(BuscarCliente)
   {
      res.send("El cliente ya existe");
      console.log("El cliente ya existe");
   }
   else
   {
      await ModeloClientes.create({
         dni,
         nombreCliente,
         apellidoCliente,
         genero,
         fechaNacimiento,
         idEstado
      })
      .then((data)=>{
         console.log(data);
         res.send("El Cliente " + data.dataValues.nombreCliente + " se registro con éxito");
      })
      .catch((error)=>{
         console.log(error);
         res.send("no se pudo guardar");
      });
   //   console.log(req.body);
     
   }
  
 }


};

exports.Eliminar = async (req,res) =>
{
   const {id } = req.query;
   if(!id)
   {
      console.log("Envie el id del cliente");
      res.send("Envie el id del cliente");
   }
   else
   {
      const BuscarCliente = await ModeloClientes.findOne({
         where:{
            idCliente: id
         }
      });

      if(!BuscarCliente)
      {
         res.send("El Cliente no existe");
         console.log("El Cliente no existe");
      }
      else
      {
         await BuscarCliente.destroy()
         .then((data)=>{
             console.log(data.dataValues);
             res.send("El regisitro se ha eliminado " + data.dataValues.nombreCliente);
         })
         .catch((error)=>{
             console.log(error);
         });
      }
   }

   
};

exports.Modificar = async (req,res) =>
{
   const {id } = req.query;
   const { dni, nombreCliente, apellidoCliente, genero, fechaNacimiento, idEstado } = req.body;
 

 if(!id || !dni || !nombreCliente || !apellidoCliente || !genero || !fechaNacimiento || !idEstado)
 {
    console.log(req.body);
    res.send("Todos los campos son obligatorios");
    console.log("Todos los campos son obligatorios");
 }
 else
 {
   const BuscarCliente = await ModeloClientes.findOne({
         where:{
            idCliente: id
         }
      });
  
   if(!BuscarCliente)
   {
      res.send("El cliente no existe");
      console.log("El cliente no existe");
   }
   else
   {
      BuscarCliente.dni = dni;
      BuscarCliente.nombreCliente= nombreCliente;
      BuscarCliente.apellidoCliente=apellidoCliente;
      BuscarCliente.genero = genero;
      BuscarCliente.fechaNacimiento = fechaNacimiento;
      BuscarCliente.idEstado = idEstado;

      
      await ModeloClientes.save()
      .then((data)=>{
         console.log(data);
         res.send("El Cliente se actualizo");
      })
      .catch((error)=>{
         console.log(error);
         res.send("no se pudo guardar");
      });
   //   console.log(req.body);
     
   }
  
 }


};