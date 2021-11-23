const express = require('express');
const morgan = require('morgan');
const app = express();
app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());
app.set('json spaces', 2);
app.use('/', require('./rutas/index'));
app.listen(3001, ()=>{
    console.log('Servidor iniciado en el puerto 3001.');
});
