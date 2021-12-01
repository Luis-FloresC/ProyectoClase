const { Router } = require('express');
const controladorCliente = require('../controladores/ControladorClientes');
const controladorUsuario = require('../controladores/controladorUsuario');
const controladorProducto = require('../controladores/controladorProductos');
const router = Router();
const con = require('../configuracion/coneccion');

router.get('/Json', (req, res)=>{
    var obj = [];

  

    con.connect(function (err) {
        if (err) throw err;
        con.query("call bd_techno_factory.ListarProductos();", function (err, result, fields) {
            if (err) throw err;
            obj = result[0];
           
            var mensaje =
            {
                dataValues:obj
            };
            console.log("Opcion:");

            
            console.log(mensaje);
            res.json(mensaje);
            //console.log(obj);
            //res.json(result);


        });
    });
   console.log("Objeto");
 //  console.log(mensaje);
    //res.render('home');
}); 

router.get('/Clientes',controladorCliente.ListaClientes);

router.get('/login', (req, res)=>{
    res.render('Login',{title:"TechnoFactory | Login"});
});

router.get('/', (req, res)=>{
    res.render('Menu' , {title:"TechnoFactory | Inicio"});
});

router.get('/productos',controladorProducto.ListarProductos);
router.get('/Usuario',controladorCliente.ListaClientes);
router.post('/Clientes',controladorCliente.Guardar);
router.delete('/Usuario',controladorCliente.Eliminar);
router.put('/Usuario',controladorCliente.Modificar);
router.post('/login',controladorUsuario.Login);
router.get('/login',controladorUsuario.ListaUsuarios);

module.exports=router;
