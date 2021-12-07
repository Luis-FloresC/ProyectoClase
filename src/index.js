const express = require('express');
const morgan = require('morgan');
const { engine } = require('express-handlebars');
const path = require('path');
const flash = require('connect-flash');
const session  = require('express-session');
const cookieParser = require('cookie-parser');
//const flash   = require('req-flash');

const app = express();
app.set('port', process.env.PORT || 4001);
app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());

app.use(cookieParser());
app.use(session({ secret: '123' }));
app.use(flash());

app.use(express.static(path.join(__dirname, 'publico')));

app.use((req, res, next) => {
  app.locals.message = req.flash('message');
  app.locals.success = req.flash('success');
  app.locals.user = req.user;
  next();
});
app.set('json spaces', 2);

//Definimos la ruta y ela rchivo main
app.engine('.hbs', engine({
    defaultLayout: 'main',
    extname: '.hbs',
    layoutsDir: path.join(__dirname, 'views/layouts')
  }))
  //Configuracion de la carpeta vistas
  app.set('view engine', '.hbs');
  app.set('views', path.join(__dirname, 'views'));

app.use('/', require('./rutas/index'));
app.use('/Clientes',require('./rutas/rutasClientes'));
app.use('/Productos',require('./rutas/rutasProductos'));

app.listen(app.get('port'), () => {
  console.log('Servidor iniciado en el puerto: ', app.get('port'));
});

