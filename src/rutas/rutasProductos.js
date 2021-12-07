const { Router } = require('express');
const controladorProducto = require('../controladores/ControladorProductos');
const router = Router();
const con = require('../configuracion/coneccion');


router.get('/FormProducto',controladorProducto.FormProducto);
router.post('/AccionesProducto',controladorProducto.Guardar_Y_Modificar);
module.exports = router;
/*
router.get('/Listar',controladorProducto.ListaClientes);

router.post('/Guardar',controladorProducto.Guardar);
router.post('/Modificar',controladorProducto.Modificar);
router.get('/ListarC',controladorProducto.Lista2);
router.get('/CargarDatos/:id',controladorProducto.cargarDatos);
router.get('/EliminarDatos/:id',controladorProducto.Eliminar);
*/
