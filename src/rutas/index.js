const { Router } = require('express');
const controladorUsuario = require('../controladores/ControladorUsuarios');
const router = Router();

router.get('/', (req, res)=>{
    res.send("Hola mundo2");
});
router.get('/login', (req, res)=>{
    res.send("Hola Usuario");
});
router.get('/productos', (req, res)=>{
    res.send("productos");
});
router.get('/Usuario',controladorUsuario.ListaClientes);
router.post('/Usuario',controladorUsuario.Guardar);
router.delete('/Usuario',controladorUsuario.Eliminar);
router.put('/Usuario',controladorUsuario.Modificar);
module.exports=router;
