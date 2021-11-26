const { Router } = require('express');
const controladorCliente = require('../controladores/ControladorClientes');
const controladorUsuario = require('../controladores/controladorUsuario');
const router = Router();

/*
router.get('/', (req, res)=>{
    
    res.render('home');
}); */

router.get('/Clientes',controladorCliente.ListaClientes);

router.get('/login', (req, res)=>{
    res.send("Hola Usuario");
});
router.get('/productos', (req, res)=>{
    res.send("productos");
});
router.get('/Usuario',controladorCliente.ListaClientes);
router.post('/Clientes',controladorCliente.Guardar);
router.delete('/Usuario',controladorCliente.Eliminar);
router.put('/Usuario',controladorCliente.Modificar);
router.post('/',controladorUsuario.Login);
router.get('/',controladorUsuario.ListaUsuarios);

module.exports=router;
