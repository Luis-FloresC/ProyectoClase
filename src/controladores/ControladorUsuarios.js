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
  
   if(!BuscarCliente)
   {
      res.send("El cliente ya existe");
      console.log("El cliente ya existe");
   }
   else
   {
     
      console.log(req.body);
      res.send("Datos enviados");
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