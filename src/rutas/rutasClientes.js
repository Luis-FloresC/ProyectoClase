const { Router } = require('express');
const controladorCliente = require('../controladores/ControladorClientes');
const router = Router();
const con = require('../configuracion/coneccion');

router.get('/Listar',controladorCliente.ListaClientes);
router.get('/FormClientes',controladorCliente.ListaClientes);
router.post('/Guardar',controladorCliente.Guardar);
router.post('/Modificar',controladorCliente.Modificar);
router.get('/ListarC',controladorCliente.Lista2);
router.get('/CargarDatos/:id',controladorCliente.cargarDatos);
router.get('/EliminarDatos/:id',controladorCliente.Eliminar);
module.exports = router;