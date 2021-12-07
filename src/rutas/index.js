const { Router } = require('express');
const controladorCliente = require('../controladores/ControladorClientes');
const controladorUsuario = require('../controladores/controladorUsuario');
const controladorProducto = require('../controladores/controladorProductos');
const router = Router();
const con = require('../configuracion/coneccion');

router.get('/Json', (req, res)=>{
    var obj = [];
    const {id} = req.params;
    

    con.connect(function (err) {
        if (err) throw err;
        con.query("call bd_techno_factory.ListarClientes();", function (err, result, fields) {
            if (err) throw err;
            obj = result[0];
           
            var mensaje =
            {
                dataValues:obj
            };
            console.log("Opcion:");

            
            //console.log(mensaje);
            res.json(result[0]);
            //console.log(obj);
            //res.json(result);


        });
    });
   console.log("Objeto: ",id);
   console.log(req.body);
   console.log(req.query);
 //  console.log(mensaje);
    //res.render('home');
}); 



router.get('/login', (req, res)=>{
    res.render('Login',{title:"Login"});
});

router.get('/', (req, res)=>{
    var año = new Date().getFullYear();
    res.render('Menu' , {title:"Inicio" ,año});
});

router.get('/productos',controladorProducto.ListarProductos);
router.get('/Usuario',controladorCliente.ListaClientes);

router.delete('/Usuario',controladorCliente.Eliminar);

router.post('/login',controladorUsuario.Login);
router.get('/login',controladorUsuario.ListaUsuarios);

module.exports=router;
