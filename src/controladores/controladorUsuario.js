const ModeloUsuario = require('../modelos/modeloUsuarios');

exports.ListaUsuarios = async (req,res)=>
{
      // var mensaje = "Bienvenido al sistema";

      const ListaDeUsuarios = await ModeloUsuario.findAll();
       var mensaje = 
       {
          texto: "Hola",
          codigo:1
       };
    //res.send("Hola");
    console.log(ListaDeUsuarios);
   //res.json(ListaDeUsuarios);
 //   res.render('home',{title: "TechnoFactory"});
};


exports.Login = async (req,res) =>{
    const {usuario , contra} = req.body;
    console.log(req.body);
    if(!usuario || !contra)
    {
         res.send("No se Permiten datos vacios");
    }
    else
    {
        res.send("no estan vacios");
    }
    
 };