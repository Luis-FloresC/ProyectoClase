-- --------------------------------------------------------
-- Host:                         192.168.100.21
-- Versión del servidor:         8.0.27-0ubuntu0.20.04.1 - (Ubuntu)
-- SO del servidor:              Linux
-- HeidiSQL Versión:             11.2.0.6213
-- --------------------------------------------------------
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
-- Volcando estructura de base de datos para bd_techno_factory
CREATE DATABASE IF NOT EXISTS `bd_techno_factory`
/*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */
/*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_techno_factory`;
-- Volcando estructura para procedimiento bd_techno_factory.AccionesClientes
DELIMITER / / CREATE PROCEDURE `AccionesClientes`(
  in id int,
  in Accion varchar(50),
  in txtDni varchar(50),
  in nombre varchar(50),
  in apellido varchar(50),
  in gen varchar(50),
  in fechaNac date,
  in estado int
) BEGIN declare ExistCliente int;
declare Edad int;
set
  Edad = (
    SELECT
      TIMESTAMPDIFF(YEAR, fechaNac, CURDATE()) AS edad
  );
set
  ExistCliente = (
    select
      count(*)
    from
      Clientes
    where
      dni = txtDni
  );
if(Accion = 'G') then if (ExistCliente > 0) then
select
  'El Cliente ya existe...' as msj;
  else if(Edad < 18) then
select
  'Debe tener una edad minima de 18 años...' as msj;
  else
insert into
  Clientes(
    dni,
    nombreCliente,
    apellidoCliente,
    genero,
    fechaNacimiento,
    idEstado
  )
values
  (txtDni, nombre, apellido, gen, fechaNac, estado);
select
  'Cliente Registrado con éxito...' as msj;
end if;
end IF;
else
set
  ExistCliente = (
    select
      count(*)
    from
      Clientes
    where
      idCliente = id
  );
if (ExistCliente = 0) then
select
  'El cliente no existe...' as msj;
  else if(Edad < 18) then
select
  'Debe tener una edad minima de 18 años...' as msj;
  else
update
  Clientes
set
  dni = txtDni,
  nombreCliente = nombre,
  apellidoCliente = apellido,
  genero = gen,
  fechaNacimiento = fechaNac,
  idEstado = estado
where
  idCliente = id;
select
  'Datos actualiados con éxito...' as msj;
end if;
end if;
end if;
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.AccionesEmpleados
DELIMITER / / CREATE PROCEDURE `AccionesEmpleados`(
  in id int,
  in Accion varchar(50),
  in txtDni varchar(50),
  in nombre varchar(50),
  in apellido varchar(50),
  in gen varchar(50),
  in fechaNac date,
  in estado int
) BEGIN declare ExistEmpleado int;
declare Edad int;
set
  Edad = (
    SELECT
      TIMESTAMPDIFF(YEAR, fechaNac, CURDATE()) AS edad
  );
set
  ExistEmpleado = (
    select
      count(*)
    from
      Empleados
    where
      dni = txtDni
  );
if(Accion = 'G') then if (ExistEmpleado > 0) then
select
  'El Empleado ya existe...' as msj;
  else if(Edad < 18) then
select
  'Debe tener una edad minima de 18 años...' as msj;
  else
insert into
  Empleados(
    dni,
    nombreEmpleado,
    apellidoEmpleado,
    genero,
    fechaNacimiento,
    idEstado
  )
values
  (txtDni, nombre, apellido, gen, fechaNac, estado);
select
  'Empleado Registrado con éxito...' as msj;
end if;
end if;
else if(Edad < 18) then
select
  'Debe tener una edad minima de 18 años...' as msj;
  else
update
  Empleados
set
  dni = txtDni,
  nombreEmpleado = nombre,
  apellidoEmpleado = apellido,
  genero = gen,
  fechaNacimiento = fechaNac,
  idEstado = estado
where
  idEmpleado = id;
select
  'Datos actualiados con éxito...' as msj;
end if;
end if;
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.AccionesProductos
DELIMITER / / CREATE PROCEDURE `AccionesProductos`(
  in accion varchar(50),
  in id int,
  in nombre varchar(50),
  in descripcion varchar(2000),
  in cantidad int,
  in categoria int,
  in estado int,
  in estandar decimal(10, 2),
  in venta decimal(10, 2),
  in modelo int
) BEGIN declare ExistNombre varchar(50);
set
  ExistNombre = (
    select
      count(*)
    from
      Productos
    where
      nombreProducto = nombre
  );
if(accion = 'G') then if(ExistNombre > 0) then
select
  'El Producto ya se encuentra registrado...' as msj;
  else if(cantidad < 0) then
select
  'La cantidad debe ser mayor o igual a 0...' as msj;
  else if(
    estandar <= 0
    or venta <= 0
  ) then
select
  'El precio debe ser mayor a 0...' as msj;
  else
INSERT INTO
  `bd_techno_factory`.`Productos` (
    `nombreProducto`,
    `descripcionProducto`,
    `cantidadExistencia`,
    `idCategoria`,
    `idEstado`,
    `precioEstandar`,
    `precioVenta`,
    `idModelo`
  )
VALUES
  (
    nombre,
    descripcion,
    cantidad,
    categoria,
    estado,
    estandar,
    venta,
    modelo
  );
select
  'Producto registrado con éxito...' as msj;
end if;
end if;
end if;
else if(cantidad < 0) then
select
  'La cantidad debe ser mayor o igual a 0...' as msj;
  else if(
    estandar <= 0
    or venta <= 0
  ) then
select
  'El precio debe ser mayor a 0...' as msj;
  else
update
  Productos
set
  nombreProducto = nombre,
  descripcionProducto = descripcion,
  cantidadExistencia = cantidad,
  idCategoria = categoria,
  idEstado = estado,
  precioEstandar = estandar,
  precioVenta = venta,
  idModelo = modelo
where
  idProducto = id;
select
  'Producto actualizado con éxito...' as msj;
end if;
end if;
end if;
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.actualizar_precio_producto
DELIMITER / / CREATE PROCEDURE `actualizar_precio_producto`(
  IN `n_cantidad` INT,
  IN `n_precio` DECIMAL(10, 2),
  IN `codigo` INT
) BEGIN DECLARE nueva_existencia int;
DECLARE nuevo_total decimal(10, 2);
DECLARE nuevo_precio decimal(10, 2);
DECLARE cant_actual int;
DECLARE pre_actual decimal(10, 2);
DECLARE actual_existencia int;
DECLARE actual_precio decimal(10, 2);
SELECT
  precioVenta,
  cantidadExistencia INTO actual_precio,
  actual_existencia
FROM
  Productos
WHERE
  idProducto = codigo;
SET
  nueva_existencia = actual_existencia + n_cantidad;
SET
  nuevo_total = n_precio;
SET
  nuevo_precio = nuevo_total;
UPDATE
  Productos
SET
  cantidadExistencia = nueva_existencia,
  precioEstandar = nuevo_precio
WHERE
  idProducto = codigo;
SELECT
  nueva_existencia,
  nuevo_precio;
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.add_detalle_temp
DELIMITER / / CREATE PROCEDURE `add_detalle_temp`(
  `codigo` INT,
  `cantidad` INT,
  `token_user` VARCHAR(50)
) BEGIN DECLARE precio_actual decimal(10, 2);
SELECT
  precioVenta INTO precio_actual
FROM
  Productos
WHERE
  idProducto = codigo;
INSERT INTO
  detalleTemporal(token_user, idProducto, cantidad, precio)
VALUES
  (token_user, codigo, cantidad, precio_actual);
SELECT
  tmp.idDetalle 'correlativo',
  tmp.idProducto 'codproducto',
  p.nombreProducto 'descripcion',
  tmp.cantidad 'cantidad',
  tmp.precio 'precio_venta'
FROM
  detalleTemporal tmp
  INNER JOIN Productos p ON tmp.idProducto = p.idProducto
WHERE
  tmp.token_user = token_user;
END / / DELIMITER;
-- Volcando estructura para tabla bd_techno_factory.Cargos
CREATE TABLE IF NOT EXISTS `Cargos` (
  `idCargo` int NOT NULL AUTO_INCREMENT,
  `descripcionCargo` varchar(50) NOT NULL,
  PRIMARY KEY (`idCargo`)
);
-- Volcando datos para la tabla bd_techno_factory.Cargos: ~4 rows (aproximadamente)
DELETE FROM
  `Cargos`;
  /*!40000 ALTER TABLE `Cargos` DISABLE KEYS */;
INSERT INTO
  `Cargos` (`idCargo`, `descripcionCargo`)
VALUES
  (1, 'Administrador'),
  (2, 'Vendedor'),
  (3, 'Gerente'),
  (4, 'Cliente');
  /*!40000 ALTER TABLE `Cargos` ENABLE KEYS */;
-- Volcando estructura para tabla bd_techno_factory.Categorias
  CREATE TABLE IF NOT EXISTS `Categorias` (
    `idCategoria` int NOT NULL AUTO_INCREMENT,
    `descripcionCategoria` varchar(50) NOT NULL,
    `idEstado` int DEFAULT NULL,
    `isActivo` tinyint DEFAULT NULL,
    PRIMARY KEY (`idCategoria`),
    KEY `FKEstado` (`idEstado`),
    CONSTRAINT `FKEstado` FOREIGN KEY (`idEstado`) REFERENCES `Estados` (`idEstado`)
  );
-- Volcando datos para la tabla bd_techno_factory.Categorias: ~8 rows (aproximadamente)
DELETE FROM
  `Categorias`;
  /*!40000 ALTER TABLE `Categorias` DISABLE KEYS */;
INSERT INTO
  `Categorias` (
    `idCategoria`,
    `descripcionCategoria`,
    `idEstado`,
    `isActivo`
  )
VALUES
  (1, 'Súper computadoras', 1, 1),
  (2, 'Macro computadoras', 1, 1),
  (3, 'Mini computadoras', 1, 1),
  (4, 'Micro computadoras', 1, 1),
  (5, 'Prueba', 1, 1),
  (6, 'Internet Applicance', 1, 1),
  (
    7,
    'Computadoras de mano (Palmtop Computers)',
    2,
    0
  ),
  (8, 'Computadoras personales', 1, 1);
  /*!40000 ALTER TABLE `Categorias` ENABLE KEYS */;
-- Volcando estructura para procedimiento bd_techno_factory.CategoriasYMas
  DELIMITER / / CREATE PROCEDURE `CategoriasYMas`(
    IN accion VARCHAR(2),
    IN tabla VARCHAR(2),
    IN codMarca INT,
    IN marca VARCHAR(50),
    IN codModelo INT,
    IN modelo VARCHAR(255),
    IN codCategoria INT,
    IN categoria varchar(255),
    IN estado int
  ) BEGIN DECLARE existModelo int;
DECLARE existMarca int;
DECLARE existCategoria int;
IF(accion = 'G') THEN IF(tabla = 'Mo') THEN
set
  existModelo = (
    SELECT
      COUNT(*)
    FROM
      Modelos m
    WHERE
      m.descripcionModelo = modelo
  );
IF(existModelo > 0) THEN
SELECT
  'El modelo ya esta registrado' AS msj;
  ELSE
INSERT INTO
  Modelos (descripcionModelo, idMarca, idEstado)
VALUES(modelo, codMarca, estado);
SELECT
  'Modelo regsitrado con éxito' AS msj;
END IF;
ELSEIF (tabla = 'M') THEN
set
  existMarca = (
    SELECT
      COUNT(*)
    FROM
      Marcas m
    WHERE
      m.descripcionMarca = marca
  );
IF(existMarca > 0) THEN
SELECT
  'La marca ya esta registrado' AS msj;
  ELSE
INSERT INTO
  Marcas (descripcionMarca, idEstado)
VALUES(marca, estado);
SELECT
  'La marca se registro con éxito' AS msj;
END IF;
ELSE
set
  existCategoria = (
    SELECT
      COUNT(*)
    FROM
      Categorias c
    WHERE
      c.descripcionCategoria = categoria
  );
IF(existCategoria > 0) THEN
SELECT
  'La Categoria ya esta registrada' AS msj;
  ELSE
INSERT INTO
  Categorias (descripcionCategoria, idEstado) VALUE(categoria, estado);
SELECT
  'La categoria se registro con éxito' AS msj;
END IF;
END IF;
ELSE IF(tabla = 'Mo') THEN
set
  existModelo = (
    SELECT
      COUNT(*)
    FROM
      Modelos m
    WHERE
      m.idModelo = codModelo
  );
IF(existModelo = 0) THEN
SELECT
  'El modelo no esta registrado' AS msj;
  ELSE
UPDATE
  Modelos m
SET
  m.descripcionModelo = modelo,
  m.idMarca = codMarca,
  m.idEstado = estado
WHERE
  m.idModelo = codModelo;
SELECT
  'Modelo actualizado con éxito' AS msj;
END IF;
ELSEIF (tabla = 'M') THEN
set
  existMarca = (
    SELECT
      COUNT(*)
    FROM
      Marcas m
    WHERE
      m.idMarca = codMarca
  );
IF(existMarca = 0) THEN
SELECT
  'La marca no esta registrado' AS msj;
  ELSE
UPDATE
  Marcas m
SET
  m.descripcionMarca = marca,
  m.idEstado = estado
WHERE
  m.idMarca = codMarca;
SELECT
  'La marca se actualizo con éxito' AS msj;
END IF;
ELSE
set
  existCategoria = (
    SELECT
      COUNT(*)
    FROM
      Categorias c
    WHERE
      c.idCategoria = codCategoria
  );
IF(existCategoria = 0) THEN
SELECT
  'La Categoria no esta registrada' AS msj;
  ELSE
UPDATE
  Categorias c
SET
  c.descripcionCategoria = categoria,
  c.idEstado = estado
WHERE
  c.idCategoria = codCategoria;
SELECT
  'La categoria se actualizo con éxito' AS msj;
END IF;
END IF;
END IF;
END / / DELIMITER;
-- Volcando estructura para tabla bd_techno_factory.Clientes
CREATE TABLE IF NOT EXISTS `Clientes` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(13) NOT NULL,
  `nombreCliente` varchar(50) NOT NULL,
  `apellidoCliente` varchar(50) NOT NULL,
  `genero` varchar(30) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `fechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEstado` int DEFAULT NULL,
  `isActivo` tinyint DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `idEstado` (`idEstado`),
  CONSTRAINT `Clientes_ibfk_1` FOREIGN KEY (`idEstado`) REFERENCES `Estados` (`idEstado`)
);
-- Volcando datos para la tabla bd_techno_factory.Clientes: ~13 rows (aproximadamente)
DELETE FROM
  `Clientes`;
  /*!40000 ALTER TABLE `Clientes` DISABLE KEYS */;
INSERT INTO
  `Clientes` (
    `idCliente`,
    `dni`,
    `nombreCliente`,
    `apellidoCliente`,
    `genero`,
    `fechaNacimiento`,
    `fechaRegistro`,
    `idEstado`,
    `isActivo`
  )
VALUES
  (
    1,
    '0703200003793',
    'Cliente',
    'Anonimos',
    'Masculino',
    '2000-08-03',
    '2021-10-19 01:14:23',
    1,
    1
  ),
  (
    2,
    '098976647564',
    'Ana',
    'Moncada',
    'Femenino',
    '1979-05-17',
    '2021-10-28 21:36:30',
    1,
    1
  ),
  (
    3,
    '0801568943234',
    'Alan',
    'Mejia',
    'Masculino',
    '2001-04-22',
    '2021-11-03 09:41:35',
    1,
    1
  ),
  (
    4,
    '13456677885',
    'Ignacio N',
    'Mejia',
    'Masculino',
    '2001-04-22',
    '2021-11-05 17:55:01',
    1,
    1
  ),
  (
    5,
    '0703200003965',
    'Gerson',
    'Martinez',
    'Masculino',
    '2000-11-02',
    '2021-11-07 01:15:41',
    1,
    1
  ),
  (
    6,
    '1',
    'Cliente General 2',
    'Ventas',
    'Masculino',
    '2000-11-03',
    '2021-11-07 21:48:25',
    2,
    0
  ),
  (
    7,
    '0705200003793',
    'Cliente',
    'Anonimos',
    'Masculino',
    '2000-08-03',
    '2021-11-23 21:26:23',
    1,
    1
  ),
  (
    8,
    '0705',
    'Cliente 2 Node',
    'Anonimos',
    'Masculino',
    '2000-08-03',
    '2021-11-23 21:32:42',
    1,
    1
  ),
  (
    9,
    '06',
    'Carlos Ardon',
    'Anonimos',
    'Masculino',
    '2000-08-03',
    '2021-11-23 21:33:02',
    1,
    1
  ),
  (
    10,
    '45556',
    'Luis Adolfo',
    'Flores',
    'Masculino',
    '2021-11-01',
    '2021-11-26 23:36:59',
    1,
    1
  ),
  (
    11,
    '0704195800045',
    'Petrona',
    'Moncada',
    'Femenino',
    '1959-11-26',
    '2021-11-26 23:40:55',
    1,
    1
  ),
  (
    12,
    '080320000376',
    'Luis Adolfo',
    'Flores',
    'Masculino',
    '2000-05-07',
    '2021-11-27 18:54:05',
    1,
    1
  ),
  (
    13,
    '0703195900506',
    'Petro',
    'Moncada',
    'Femenino',
    '1956-11-26',
    '2021-11-29 21:47:44',
    1,
    1
  );
  /*!40000 ALTER TABLE `Clientes` ENABLE KEYS */;
-- Volcando estructura para procedimiento bd_techno_factory.configuracion
  DELIMITER / / CREATE PROCEDURE `configuracion`() BEGIN
select
  1 'id',
  2580 'dni',
  'Techno Factory' as nombre,
  'Techno Factory' as razon_social,
  96362917 'telefono',
  'technofactory07@gmail.com' as email,
  'Danli - Honduras' as direccion,
  15 'igv';
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.del_detalle_temp
DELIMITER / / CREATE PROCEDURE `del_detalle_temp`(`id_detalle` INT, `token` VARCHAR(50)) BEGIN
DELETE FROM
  detalleTemporal
WHERE
  idDetalle = id_detalle;
SELECT
  tmp.idDetalle 'correlativo',
  tmp.idProducto 'codproducto',
  p.nombreProducto 'descripcion',
  tmp.cantidad,
  tmp.precio_venta
FROM
  detalleTemporal tmp
  INNER JOIN producto p ON tmp.codproducto = p.codproducto
WHERE
  tmp.token_user = token;
END / / DELIMITER;
-- Volcando estructura para tabla bd_techno_factory.detalleTemporal
CREATE TABLE IF NOT EXISTS `detalleTemporal` (
  `idDetalle` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(45) NOT NULL,
  `idProducto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`idDetalle`)
);
-- Volcando datos para la tabla bd_techno_factory.detalleTemporal: ~0 rows (aproximadamente)
DELETE FROM
  `detalleTemporal`;
  /*!40000 ALTER TABLE `detalleTemporal` DISABLE KEYS */;
  /*!40000 ALTER TABLE `detalleTemporal` ENABLE KEYS */;
-- Volcando estructura para tabla bd_techno_factory.DetalleVentas
  CREATE TABLE IF NOT EXISTS `DetalleVentas` (
    `idDetalle` int NOT NULL AUTO_INCREMENT,
    `idVenta` int NOT NULL,
    `idProducto` int NOT NULL,
    `cantidad` int NOT NULL,
    `precio` decimal(10, 2) NOT NULL,
    PRIMARY KEY (`idVenta`, `idDetalle`),
    KEY `idProducto` (`idProducto`),
    KEY `idDetalle` (`idDetalle`),
    CONSTRAINT `DetalleVentas_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`),
    CONSTRAINT `DetalleVentas_ibfk_2` FOREIGN KEY (`idVenta`) REFERENCES `Ventas` (`idVenta`)
  );
-- Volcando datos para la tabla bd_techno_factory.DetalleVentas: ~119 rows (aproximadamente)
DELETE FROM
  `DetalleVentas`;
  /*!40000 ALTER TABLE `DetalleVentas` DISABLE KEYS */;
INSERT INTO
  `DetalleVentas` (
    `idDetalle`,
    `idVenta`,
    `idProducto`,
    `cantidad`,
    `precio`
  )
VALUES
  (2, 7, 1, 1, 32000.00),
  (3, 7, 2, 1, 35000.00),
  (5, 8, 2, 1, 35000.00),
  (6, 8, 1, 4, 32000.00),
  (8, 9, 2, 2, 35000.00),
  (9, 10, 2, 4, 35000.00),
  (10, 11, 1, 1, 32000.00),
  (11, 11, 2, 2, 35000.00),
  (13, 12, 2, 1, 35000.00),
  (14, 13, 2, 2, 35000.00),
  (15, 14, 2, 1, 35000.00),
  (16, 15, 1, 1, 32000.00),
  (17, 16, 2, 1, 35000.00),
  (18, 17, 2, 3, 35000.00),
  (19, 18, 2, 2, 35000.00),
  (20, 19, 2, 1, 35000.00),
  (21, 20, 2, 3, 35000.00),
  (22, 21, 2, 1, 35000.00),
  (23, 22, 2, 1, 35000.00),
  (24, 23, 2, 1, 35000.00),
  (25, 24, 1, 5, 32000.00),
  (26, 24, 2, 1, 35000.00),
  (27, 24, 3, 1, 45000.00),
  (28, 25, 3, 1, 45000.00),
  (29, 26, 1, 1, 32000.00),
  (30, 27, 2, 1, 35000.00),
  (31, 28, 3, 1, 45000.00),
  (32, 29, 1, 1, 32000.00),
  (33, 30, 3, 1, 45000.00),
  (34, 30, 2, 1, 35000.00),
  (35, 30, 2, 2, 35000.00),
  (36, 31, 1, 1, 32000.00),
  (37, 32, 1, 2, 32000.00),
  (38, 33, 1, 1, 32000.00),
  (39, 34, 1, 2, 32000.00),
  (40, 35, 1, 1, 32000.00),
  (41, 36, 2, 1, 35000.00),
  (42, 37, 2, 1, 35000.00),
  (43, 38, 1, 1, 32000.00),
  (44, 39, 1, 1, 32000.00),
  (45, 40, 1, 1, 32000.00),
  (46, 41, 1, 1, 32000.00),
  (47, 42, 1, 1, 32000.00),
  (48, 43, 1, 1, 32000.00),
  (49, 44, 1, 1, 32000.00),
  (50, 45, 1, 1, 32000.00),
  (51, 45, 2, 1, 35000.00),
  (52, 45, 3, 1, 45000.00),
  (53, 46, 2, 1, 35000.00),
  (54, 46, 1, 1, 32000.00),
  (55, 46, 3, 1, 45000.00),
  (56, 47, 2, 2, 35000.00),
  (57, 47, 3, 1, 45000.00),
  (58, 48, 3, 3, 45000.00),
  (59, 49, 2, 1, 35000.00),
  (60, 49, 1, 1, 32000.00),
  (62, 50, 1, 1, 32000.00),
  (63, 50, 2, 2, 35000.00),
  (64, 50, 3, 5, 45000.00),
  (65, 51, 1, 4, 32000.00),
  (66, 51, 2, 2, 35000.00),
  (68, 52, 1, 1, 32000.00),
  (69, 53, 2, 5, 35000.00),
  (70, 54, 3, 5, 45000.00),
  (71, 55, 1, 1, 32000.00),
  (72, 56, 2, 1, 35000.00),
  (73, 57, 1, 1, 32000.00),
  (74, 58, 1, 2, 32000.00),
  (75, 58, 2, 1, 35000.00),
  (76, 58, 3, 1, 45000.00),
  (77, 59, 2, 1, 35000.00),
  (78, 60, 2, 1, 35000.00),
  (79, 61, 2, 2, 35000.00),
  (80, 62, 2, 1, 35000.00),
  (81, 63, 2, 1, 35000.00),
  (82, 64, 1, 1, 32000.00),
  (83, 65, 2, 1, 35000.00),
  (84, 66, 1, 1, 32000.00),
  (85, 67, 1, 1, 32000.00),
  (86, 68, 1, 1, 32000.00),
  (87, 69, 1, 2, 32000.00),
  (88, 70, 3, 1, 45000.00),
  (89, 71, 2, 1, 35000.00),
  (90, 72, 2, 1, 35000.00),
  (91, 73, 1, 2, 32000.00),
  (92, 73, 2, 3, 35000.00),
  (93, 73, 3, 1, 45000.00),
  (94, 73, 3, 4, 45000.00),
  (98, 74, 2, 1, 35000.00),
  (99, 74, 3, 1, 45000.00),
  (101, 75, 1, 1, 32000.00),
  (102, 75, 2, 1, 35000.00),
  (103, 75, 3, 1, 45000.00),
  (104, 76, 1, 2, 32000.00),
  (105, 76, 2, 3, 35000.00),
  (107, 77, 1, 1, 32000.00),
  (108, 77, 2, 1, 35000.00),
  (109, 77, 3, 1, 45000.00),
  (110, 78, 1, 1, 32000.00),
  (111, 78, 3, 2, 45000.00),
  (113, 79, 1, 1, 32000.00),
  (114, 80, 2, 2, 35000.00),
  (115, 80, 1, 1, 32000.00),
  (116, 81, 1, 1, 32000.00),
  (117, 82, 2, 1, 35000.00),
  (118, 82, 3, 1, 45000.00),
  (119, 82, 13, 3, 11995.00),
  (120, 83, 2, 1, 35000.00),
  (121, 83, 3, 1, 45000.00),
  (123, 84, 2, 1, 35000.00),
  (124, 85, 17, 1, 42000.00),
  (125, 85, 8, 4, 10000.00),
  (126, 85, 1, 5, 32000.00),
  (127, 85, 2, 3, 35000.00),
  (128, 85, 3, 1, 45000.00),
  (129, 85, 13, 1, 11995.00),
  (131, 86, 13, 1, 11995.00),
  (132, 86, 1, 1, 32000.00),
  (134, 87, 2, 2, 35000.00),
  (135, 88, 1, 2, 32000.00),
  (136, 88, 13, 1, 11995.00),
  (137, 89, 1, 1, 32000.00),
  (138, 89, 1, 1, 32000.00),
  (139, 89, 1, 1, 32000.00);
  /*!40000 ALTER TABLE `DetalleVentas` ENABLE KEYS */;
-- Volcando estructura para procedimiento bd_techno_factory.EditarUsuario
  DELIMITER / / CREATE PROCEDURE `EditarUsuario`(
    in id int,
    in nombreUser varchar(50),
    in contra varchar(50),
    in cargo int,
    in correo varchar(100),
    in codEmpleado int
  ) BEGIN
update
  Usuarios
set
  nombreUsuario = nombreUser,
  contrasenia = contra,
  idCargo = cargo,
  idEmpleado = codEmpleado,
  correoElectronico = correo
where
  idUsuario = id;
select
  'La información del usuario se actualizo con éxito...' as msj;
END / / DELIMITER;
-- Volcando estructura para tabla bd_techno_factory.Empleados
CREATE TABLE IF NOT EXISTS `Empleados` (
  `idEmpleado` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(45) DEFAULT NULL,
  `nombreEmpleado` varchar(50) NOT NULL,
  `apellidoEmpleado` varchar(50) NOT NULL,
  `genero` varchar(30) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `fechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEstado` int DEFAULT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `idEstado` (`idEstado`),
  CONSTRAINT `Empleados_ibfk_1` FOREIGN KEY (`idEstado`) REFERENCES `Estados` (`idEstado`)
);
-- Volcando datos para la tabla bd_techno_factory.Empleados: ~8 rows (aproximadamente)
DELETE FROM
  `Empleados`;
  /*!40000 ALTER TABLE `Empleados` DISABLE KEYS */;
INSERT INTO
  `Empleados` (
    `idEmpleado`,
    `dni`,
    `nombreEmpleado`,
    `apellidoEmpleado`,
    `genero`,
    `fechaNacimiento`,
    `fechaRegistro`,
    `idEstado`
  )
VALUES
  (
    1,
    '0703200003793',
    'Luis',
    'Flores',
    'Masculino',
    '2000-06-07',
    '2021-10-20 14:55:37',
    1
  ),
  (
    2,
    '0801200003786',
    'Adolfo',
    'Castellanos',
    'Masculino',
    '2000-03-07',
    '2021-10-30 10:08:47',
    1
  ),
  (
    3,
    '2',
    'Diego',
    'Lopez',
    'Masculino',
    '2000-07-06',
    '2021-10-31 00:12:09',
    1
  ),
  (
    4,
    '0896065643',
    'Allan',
    'Mejia',
    'Masculino',
    '2000-09-08',
    '2021-11-01 21:46:53',
    1
  ),
  (
    5,
    '0704200003798',
    'Nayeli',
    'Ardon',
    'Femenino',
    '2000-09-07',
    '2021-11-02 13:04:43',
    1
  ),
  (
    6,
    '07004197702343223',
    'Luis',
    'Castellanos',
    'Masculino',
    '2000-11-23',
    '2021-11-02 16:52:54',
    1
  ),
  (
    7,
    '07043000047841',
    'Luis Adolfo',
    'Flores',
    'Masculino',
    '2000-11-17',
    '2021-11-07 01:16:39',
    1
  ),
  (
    8,
    '0801200003793',
    'Luis Adolfo',
    'Flores Cstellanos',
    'Masculino',
    '2000-11-10',
    '2021-11-08 15:27:22',
    1
  );
  /*!40000 ALTER TABLE `Empleados` ENABLE KEYS */;
-- Volcando estructura para tabla bd_techno_factory.Estados
  CREATE TABLE IF NOT EXISTS `Estados` (
    `idEstado` int NOT NULL AUTO_INCREMENT,
    `estado` varchar(50) NOT NULL,
    PRIMARY KEY (`idEstado`)
  );
-- Volcando datos para la tabla bd_techno_factory.Estados: ~2 rows (aproximadamente)
DELETE FROM
  `Estados`;
  /*!40000 ALTER TABLE `Estados` DISABLE KEYS */;
INSERT INTO
  `Estados` (`idEstado`, `estado`)
VALUES
  (1, 'habilitado'),
  (2, 'deshabilitado');
  /*!40000 ALTER TABLE `Estados` ENABLE KEYS */;
-- Volcando estructura para procedimiento bd_techno_factory.Factura
  DELIMITER / / CREATE PROCEDURE `Factura`(in noFactura int) BEGIN
SELECT
  d.idVenta 'nofactura',
  d.idProducto 'codproducto',
  d.cantidad,
  p.idProducto 'codproducto',
  p.nombreProducto 'descripcion',
  p.precioVenta 'precio'
FROM
  DetalleVentas d
  INNER JOIN Productos p ON d.idVenta = noFactura
WHERE
  d.idProducto = p.idProducto;
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.ListarProductos
DELIMITER / / CREATE PROCEDURE `ListarProductos`() BEGIN declare i int;
SET
  @row_number = 0;
select
  p.idProducto AS num,
  p.nombreProducto 'nombre',
  p.descripcionProducto 'descripcion',
  m.descripcionModelo 'modelo',
  ma.descripcionMarca 'marca',
  c.descripcionCategoria 'categoria',
  p.cantidadExistencia 'cantidad',
  p.precioVenta 'precio',
  e.estado
from
  Productos p
  join Modelos m on m.idModelo = p.idModelo
  JOIN Marcas ma on ma.idMarca = m.idMarca
  join Categorias c on c.idCategoria = p.idCategoria
  join Estados e on e.idEstado = p.idEstado
order by
  p.idProducto;
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.ListarUsuarios
DELIMITER / / CREATE PROCEDURE `ListarUsuarios`() BEGIN
SET
  @row_number = 0;
select
  (@row_number: = @row_number + 1) AS num,
  concat(e.nombreEmpleado, ' ', e.apellidoEmpleado) as nombre,
  u.correoElectronico as Email,
  u.nombreUsuario 'user',
  c.descripcionCargo as cargo,
  u.idUsuario
from
  Usuarios u
  join Empleados e on u.idEmpleado = e.idEmpleado
  join Cargos c on c.idCargo = u.idCargo;
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.ListarVentas
DELIMITER / / CREATE PROCEDURE `ListarVentas`() BEGIN
select
  dv.idVenta 'no',
  v.fechaVenta 'fecha',
  concat(c.nombreCliente, ' ', c.apellidoCliente) 'Cliente',
  p.nombreProducto 'nombre',
  dv.cantidad,
  dv.precio,
  sum(dv.cantidad * dv.precio) 'SubTotal'
from
  Ventas v
  join DetalleVentas dv on v.idVenta = dv.idVenta
  join Productos p on p.idProducto = dv.idProducto
  join Clientes c on c.idCliente = v.idCliente
  join Empleados e on e.idEmpleado = v.idEmpleado
group by
  dv.idVenta,
  v.fechaVenta,
  p.nombreProducto,
  dv.cantidad,
  dv.precio,
  c.nombreCliente,
  c.apellidoCliente
order by
  v.idVenta desc;
END / / DELIMITER;
-- Volcando estructura para procedimiento bd_techno_factory.Login
DELIMITER / / CREATE PROCEDURE `Login`(in usuario varchar(50), in contra varchar(50)) BEGIN
select
  coalesce(c.idCliente, e.idEmpleado) 'id',
  coalesce(c.nombreCliente, e.nombreEmpleado) 'nombre',
  coalesce(c.apellidoCliente, e.apellidoEmpleado) 'apellido',
  u.nombreUsuario 'user',
  u.contrasenia 'contra',
  u.correoElectronico 'correo',
  ca.descripcionCargo 'cargo',
  u.isEmpleado
from
  Usuarios u
  left join Empleados e on e.idEmpleado = u.idEmpleado
  left join Clientes c on c.idCliente = u.idCliente
  join Cargos ca on ca.idCargo = u.idCargo
where
  u.nombreUsuario = usuario
  and u.contrasenia = contra;
END / / DELIMITER;
-- Volcando estructura para tabla bd_techno_factory.Marcas
CREATE TABLE IF NOT EXISTS `Marcas` (
  `idMarca` int NOT NULL AUTO_INCREMENT,
  `descripcionMarca` varchar(50) NOT NULL,
  `idEstado` int DEFAULT NULL,
  PRIMARY KEY (`idMarca`),
  KEY `FKMarca_Estado` (`idEstado`),
  CONSTRAINT `FKMarca_Estado` FOREIGN KEY (`idEstado`) REFERENCES `Estados` (`idEstado`)
);
-- Volcando datos para la tabla bd_techno_factory.Marcas: ~8 rows (aproximadamente)
DELETE FROM
  `Marcas`;
  /*!40000 ALTER TABLE `Marcas` DISABLE KEYS */;
INSERT INTO
  `Marcas` (`idMarca`, `descripcionMarca`, `idEstado`)
VALUES
  (1, 'Dell', 1),
  (2, 'Toshiba', 1),
  (3, 'HP', 1),
  (4, 'Acer', 1),
  (5, 'Apple', 2),
  (6, 'Lenovo', 2),
  (7, 'Lenovo2', 2),
  (8, 'LEN', 1);
  /*!40000 ALTER TABLE `Marcas` ENABLE KEYS */;
-- Volcando estructura para tabla bd_techno_factory.Modelos
  CREATE TABLE IF NOT EXISTS `Modelos` (
    `idModelo` int NOT NULL AUTO_INCREMENT,
    `descripcionModelo` varchar(50) NOT NULL,
    `idMarca` int DEFAULT NULL,
    `idEstado` int DEFAULT NULL,
    `isActivo` tinyint DEFAULT NULL,
    PRIMARY KEY (`idModelo`),
    KEY `idMarca` (`idMarca`),
    KEY `Fk_Estado` (`idEstado`),
    CONSTRAINT `Fk_Estado` FOREIGN KEY (`idEstado`) REFERENCES `Estados` (`idEstado`),
    CONSTRAINT `Modelos_ibfk_1` FOREIGN KEY (`idMarca`) REFERENCES `Marcas` (`idMarca`)
  );
-- Volcando datos para la tabla bd_techno_factory.Modelos: ~6 rows (aproximadamente)
DELETE FROM
  `Modelos`;
  /*!40000 ALTER TABLE `Modelos` DISABLE KEYS */;
INSERT INTO
  `Modelos` (
    `idModelo`,
    `descripcionModelo`,
    `idMarca`,
    `idEstado`,
    `isActivo`
  )
VALUES
  (1, 'Notebook', 3, 1, 1),
  (2, 'Pavilion', 3, 1, 1),
  (3, 'Inspiron', 1, 1, 1),
  (4, 'Chromebook ', 1, 1, 1),
  (5, 'MacBook', 5, 1, 1),
  (6, 'MacBook Air', 5, 1, 1);
  /*!40000 ALTER TABLE `Modelos` ENABLE KEYS */;
-- Volcando estructura para procedimiento bd_techno_factory.procesar_venta
  DELIMITER / / CREATE PROCEDURE `procesar_venta`(
    IN `cod_usuario` INT,
    IN `cod_cliente` INT,
    IN `token` VARCHAR(50)
  ) BEGIN DECLARE factura INT;
DECLARE registros INT;
DECLARE total DECIMAL(10, 2);
DECLARE nueva_existencia int;
DECLARE existencia_actual int;
DECLARE tmp_cod_producto int;
DECLARE tmp_cant_producto int;
DECLARE a int;
SET
  a = 1;
CREATE TEMPORARY TABLE tbl_tmp_tokenuser(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cod_prod BIGINT,
    cant_prod int
  );
SET
  registros = (
    SELECT
      COUNT(*)
    FROM
      detalleTemporal
    WHERE
      token_user = token
  );
IF registros > 0 THEN
INSERT INTO
  tbl_tmp_tokenuser(cod_prod, cant_prod)
SELECT
  idProducto,
  cantidad
FROM
  detalleTemporal
WHERE
  token_user = token;
INSERT INTO
  Ventas (idEmpleado, idCliente, isv, descuento)
VALUES
  (cod_usuario, cod_cliente, 15, 0);
SET
  factura = LAST_INSERT_ID();
INSERT INTO
  DetalleVentas(idVenta, idProducto, cantidad, precio)
SELECT
  (factura) AS nofactura,
  idProducto,
  cantidad,
  precio
FROM
  detalleTemporal
WHERE
  token_user = token;
WHILE a <= registros DO
SELECT
  cod_prod,
  cant_prod INTO tmp_cod_producto,
  tmp_cant_producto
FROM
  tbl_tmp_tokenuser
WHERE
  id = a;
SELECT
  cantidadExistencia INTO existencia_actual
FROM
  Productos
WHERE
  idProducto = tmp_cod_producto;
SET
  nueva_existencia = existencia_actual - tmp_cant_producto;
UPDATE
  Productos
SET
  cantidadExistencia = nueva_existencia
WHERE
  idProducto = tmp_cod_producto;
SET
  a = a + 1;
END WHILE;
SET
  total = (
    SELECT
      SUM(cantidad * precio)
    FROM
      detalleTemporal
    WHERE
      token_user = token
  );
UPDATE
  Ventas
SET
  subTotal = total
WHERE
  idVenta = factura;
TRUNCATE TABLE detalleTemporal;
TRUNCATE TABLE tbl_tmp_tokenuser;
SELECT
  *
FROM
  Ventas
WHERE
  idVenta = factura;
  ELSE
SELECT
  0;
END IF;
END / / DELIMITER;
-- Volcando estructura para tabla bd_techno_factory.Productos
CREATE TABLE IF NOT EXISTS `Productos` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `nombreProducto` varchar(50) NOT NULL,
  `descripcionProducto` varchar(2000) NOT NULL,
  `cantidadExistencia` int NOT NULL,
  `idCategoria` int DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  `precioEstandar` decimal(10, 2) NOT NULL,
  `precioVenta` decimal(10, 2) NOT NULL,
  `idModelo` int DEFAULT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `idModelo` (`idModelo`),
  KEY `idEstado` (`idEstado`),
  KEY `idCategoria` (`idCategoria`),
  CONSTRAINT `Productos_ibfk_1` FOREIGN KEY (`idModelo`) REFERENCES `Modelos` (`idModelo`),
  CONSTRAINT `Productos_ibfk_2` FOREIGN KEY (`idEstado`) REFERENCES `Estados` (`idEstado`),
  CONSTRAINT `Productos_ibfk_3` FOREIGN KEY (`idCategoria`) REFERENCES `Categorias` (`idCategoria`)
);
-- Volcando datos para la tabla bd_techno_factory.Productos: ~7 rows (aproximadamente)
DELETE FROM
  `Productos`;
  /*!40000 ALTER TABLE `Productos` DISABLE KEYS */;
INSERT INTO
  `Productos` (
    `idProducto`,
    `nombreProducto`,
    `descripcionProducto`,
    `cantidadExistencia`,
    `idCategoria`,
    `idEstado`,
    `precioEstandar`,
    `precioVenta`,
    `idModelo`
  )
VALUES
  (
    1,
    'Inspiron 15 5000',
    'Laptop de 15 pulgadas que es su centro personal de entretenimiento en el hogar para una visualización envolvente, con un borde estrecho y un procesador Intel® de décima generación.',
    39,
    4,
    1,
    32000.00,
    32000.00,
    3
  ),
  (
    2,
    'HP Laptop 15-gw0017la',
    'Creada para mantenerte productivo y conectado, la HP Laptop 15 combina batería de larga duración y una pantalla de bordes súper delgado, en un diseño con mucho estilo.',
    0,
    4,
    1,
    35000.00,
    35000.00,
    2
  ),
  (
    3,
    'MacBook Pro de 13”',
    'Con el chip M1, la MacBook Pro de 13 pulgadas alcanza un nuevo nivel de potencia y velocidad. El CPU es hasta 2.8 veces más rápido y los gráficos son hasta 5 veces más veloces. Nuestro Neural Engine más avanzado hasta ahora permite un aprendizaje automático hasta 11 veces más rápido. Y la batería te acompaña todo el día: hasta 20 horas de duración. Es nuestra notebook Pro más conocida, a un nivel mucho más pro.',
    15,
    4,
    1,
    40000.00,
    45000.00,
    5
  ),
  (
    8,
    'Laptop Dell Inspiron 15" ',
    'Laptop de 15 pulgadas que ofrece un rendimiento con capacidad de respuesta en un diseño elegante con bordes angostos de dos lados, ExpressCharge, y procesadores Intel Core.  Cap. Disco Duro (5400 RPM) GB - 1 TB Memoria RAM Instalada GB - 4 GB Procesador - Intel Core i3 Resolución Pantalla (Pixeles) - 1366 x 768 Pixeles',
    56,
    4,
    1,
    10000.00,
    10000.00,
    3
  ),
  (
    13,
    'Laptop HP 250 G7 15" ',
    'Laptop HP 250 G7 15" Intel Core i3 Memoria RAM 4GB/ Disco Duro 1TB Negra\nHP-250-G7\nCap. Disco Duro (5400 RPM) GB - 1 TB\nMemoria RAM Instalada GB - 4GB\nProcesador - Intel Core i3 (10ma generación)\nResolución Pantalla (Pixeles) - 1366 x 768 pixeles',
    17,
    4,
    1,
    10000.00,
    11995.00,
    3
  ),
  (
    17,
    'Lenovo Chromebook 2-en-1 Laptop convertible',
    'Lector de alto rendimiento: el Chromebook C330 está equipado con un procesador MediaTek MTK8173C, Chrome OS, 4 GB LPDDR3, 64 GB eMMC 5.1 y mucho más.\nDiseño elegante y elegante: elegante, elegante y seguro, este pequeño portátil tiene menos de una pulgada de grosor y 2,6 libras. con una pantalla táctil IPS FHD de 11 pulgadas perfecta para la informática diaria y multimedia, en línea o sin conexión.',
    49,
    3,
    1,
    36000.00,
    42000.00,
    4
  ),
  (
    18,
    'Laptop Dell Inspiron 14"',
    'Laptop 2 en 1 de 14 pulgadas diseñada para acercar su mundo. Cuenta con un borde estrecho de 4 lados y los últimos procesadores Intel® Core™ de 11.ª generación.\n\nCap. Disco Duro Solido (GB) - 256 GB\nMemoria RAM Instalada GB - 8 GB\nProcesador - Intel Core i3\nResolución Pantalla (Pixeles) - 1920 x 1080 pixeles',
    24,
    8,
    1,
    20000.00,
    23999.00,
    3
  ),
  (
    19,
    'Laptop Dell Inspiron 156" ',
    '4gb de ram ,220 ssd',
    20,
    8,
    1,
    10000.00,
    10000.00,
    3
  );
  /*!40000 ALTER TABLE `Productos` ENABLE KEYS */;
-- Volcando estructura para procedimiento bd_techno_factory.RegistrarUsuarios
  DELIMITER / / CREATE PROCEDURE `RegistrarUsuarios`(
    in nombreUser varchar(50),
    in contra varchar(50),
    in cargo int,
    in correo varchar(100),
    in codEmpleado int
  ) BEGIN declare EmpleadoExistente int;
declare tieneUsuario int;
set
  tieneUsuario = (
    select
      count(*)
    from
      Usuarios
    where
      idEmpleado = codEmpleado
  );
set
  EmpleadoExistente = (
    select
      count(*)
    from
      Empleados
    where
      idEmpleado = codEmpleado
  );
if (EmpleadoExistente = 0) then
select
  'El Empleado no esta registrado en la base de datos' as msj;
  else if(tieneUsuario > 0) then
select
  'El Empleado ya cuenta con un usuario registrado' as msj;
  else
insert into
  Usuarios (
    nombreUsuario,
    contrasenia,
    idCargo,
    correoElectronico,
    idEmpleado,
    isEmpleado
  )
values
  (nombreUser, contra, cargo, correo, codEmpleado, 1);
select
  'Usuario Registrado con éxito' as msj;
end if;
end if;
END / / DELIMITER;
-- Volcando estructura para tabla bd_techno_factory.Usuarios
CREATE TABLE IF NOT EXISTS `Usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombreUsuario` varchar(50) DEFAULT NULL,
  `contrasenia` varchar(50) DEFAULT NULL,
  `idCargo` int DEFAULT NULL,
  `correoElectronico` varchar(100) DEFAULT NULL,
  `idEmpleado` int DEFAULT NULL,
  `idCliente` int DEFAULT NULL,
  `isEmpleado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `idCliente` (`idCliente`),
  KEY `idCargo` (`idCargo`),
  KEY `idEmpleado` (`idEmpleado`),
  CONSTRAINT `Usuarios_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `Clientes` (`idCliente`),
  CONSTRAINT `Usuarios_ibfk_2` FOREIGN KEY (`idCargo`) REFERENCES `Cargos` (`idCargo`),
  CONSTRAINT `Usuarios_ibfk_3` FOREIGN KEY (`idEmpleado`) REFERENCES `Empleados` (`idEmpleado`)
);
-- Volcando datos para la tabla bd_techno_factory.Usuarios: ~5 rows (aproximadamente)
DELETE FROM
  `Usuarios`;
  /*!40000 ALTER TABLE `Usuarios` DISABLE KEYS */;
INSERT INTO
  `Usuarios` (
    `idUsuario`,
    `nombreUsuario`,
    `contrasenia`,
    `idCargo`,
    `correoElectronico`,
    `idEmpleado`,
    `idCliente`,
    `isEmpleado`
  )
VALUES
  (
    2,
    'Luis',
    'luis1234flores',
    4,
    'luis123@gmail.com',
    NULL,
    1,
    0
  ),
  (
    6,
    'luis',
    'luis1234',
    1,
    'lf016158@gmail.com',
    1,
    NULL,
    1
  ),
  (
    7,
    'DiegoL',
    '12345',
    2,
    'diego123@gmail.com',
    3,
    NULL,
    1
  ),
  (
    8,
    'AlanMejia',
    '12345678',
    3,
    'alan123@gmail.com',
    4,
    NULL,
    1
  ),
  (
    9,
    'LuisF',
    'luis1234flores',
    2,
    'lf016158@gmail.com',
    2,
    NULL,
    1
  );
  /*!40000 ALTER TABLE `Usuarios` ENABLE KEYS */;
-- Volcando estructura para tabla bd_techno_factory.Ventas
  CREATE TABLE IF NOT EXISTS `Ventas` (
    `idVenta` int NOT NULL AUTO_INCREMENT,
    `fechaVenta` datetime DEFAULT CURRENT_TIMESTAMP,
    `idCliente` int DEFAULT NULL,
    `idEmpleado` int DEFAULT NULL,
    `isv` decimal(10, 2) DEFAULT NULL,
    `descuento` decimal(10, 2) DEFAULT NULL,
    `subTotal` decimal(10, 2) DEFAULT NULL,
    PRIMARY KEY (`idVenta`),
    KEY `idCliente` (`idCliente`),
    KEY `Ventas_Empleados_idx` (`idEmpleado`),
    CONSTRAINT `Ventas_Empleados` FOREIGN KEY (`idEmpleado`) REFERENCES `Empleados` (`idEmpleado`),
    CONSTRAINT `Ventas_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `Clientes` (`idCliente`)
  );
-- Volcando datos para la tabla bd_techno_factory.Ventas: ~66 rows (aproximadamente)
DELETE FROM
  `Ventas`;
  /*!40000 ALTER TABLE `Ventas` DISABLE KEYS */;
INSERT INTO
  `Ventas` (
    `idVenta`,
    `fechaVenta`,
    `idCliente`,
    `idEmpleado`,
    `isv`,
    `descuento`,
    `subTotal`
  )
VALUES
  (
    6,
    '2021-10-27 15:18:18',
    1,
    1,
    15.00,
    0.00,
    NULL
  ),
  (
    7,
    '2021-10-27 15:22:19',
    1,
    1,
    15.00,
    0.00,
    67000.00
  ),
  (
    8,
    '2021-10-27 15:26:13',
    1,
    1,
    15.00,
    0.00,
    163000.00
  ),
  (
    9,
    '2021-10-27 15:40:40',
    1,
    1,
    15.00,
    0.00,
    70000.00
  ),
  (
    10,
    '2021-10-27 15:42:40',
    1,
    1,
    15.00,
    0.00,
    140000.00
  ),
  (
    11,
    '2021-10-27 15:49:58',
    1,
    1,
    15.00,
    0.00,
    102000.00
  ),
  (
    12,
    '2021-10-27 15:52:35',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    13,
    '2021-10-27 16:00:42',
    1,
    1,
    15.00,
    0.00,
    70000.00
  ),
  (
    14,
    '2021-10-27 16:07:36',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    15,
    '2021-10-27 16:09:38',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    16,
    '2021-10-27 16:10:56',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    17,
    '2021-10-27 16:18:29',
    1,
    1,
    15.00,
    0.00,
    105000.00
  ),
  (
    18,
    '2021-10-27 16:28:10',
    1,
    1,
    15.00,
    0.00,
    70000.00
  ),
  (
    19,
    '2021-10-27 16:39:14',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    20,
    '2021-10-27 16:51:39',
    1,
    1,
    15.00,
    0.00,
    105000.00
  ),
  (
    21,
    '2021-10-27 17:04:20',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    22,
    '2021-10-27 17:05:07',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    23,
    '2021-10-27 20:57:03',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    24,
    '2021-10-27 21:39:10',
    1,
    1,
    15.00,
    0.00,
    240000.00
  ),
  (
    25,
    '2021-10-27 21:45:25',
    1,
    1,
    15.00,
    0.00,
    45000.00
  ),
  (
    26,
    '2021-10-28 01:17:44',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    27,
    '2021-10-28 01:18:54',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    28,
    '2021-10-28 01:19:39',
    1,
    1,
    15.00,
    0.00,
    45000.00
  ),
  (
    29,
    '2021-10-28 01:23:43',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    30,
    '2021-10-28 01:24:49',
    1,
    1,
    15.00,
    0.00,
    150000.00
  ),
  (
    31,
    '2021-10-28 01:26:44',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    32,
    '2021-10-28 01:31:12',
    1,
    1,
    15.00,
    0.00,
    64000.00
  ),
  (
    33,
    '2021-10-28 01:32:10',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    34,
    '2021-10-28 01:33:35',
    1,
    1,
    15.00,
    0.00,
    64000.00
  ),
  (
    35,
    '2021-10-28 01:34:24',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    36,
    '2021-10-28 01:44:46',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    37,
    '2021-10-28 01:48:27',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    38,
    '2021-10-28 01:59:39',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    39,
    '2021-10-28 02:02:25',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    40,
    '2021-10-28 02:04:17',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    41,
    '2021-10-28 02:05:05',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    42,
    '2021-10-28 02:05:59',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    43,
    '2021-10-28 02:07:51',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    44,
    '2021-10-28 02:19:13',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    45,
    '2021-10-28 03:16:28',
    1,
    1,
    15.00,
    0.00,
    112000.00
  ),
  (
    46,
    '2021-10-28 06:07:06',
    1,
    1,
    15.00,
    0.00,
    112000.00
  ),
  (
    47,
    '2021-10-28 06:13:50',
    1,
    1,
    15.00,
    0.00,
    115000.00
  ),
  (
    48,
    '2021-10-28 07:25:21',
    1,
    1,
    15.00,
    0.00,
    135000.00
  ),
  (
    49,
    '2021-10-28 21:21:46',
    1,
    1,
    15.00,
    0.00,
    67000.00
  ),
  (
    50,
    '2021-10-28 21:37:48',
    2,
    1,
    15.00,
    0.00,
    327000.00
  ),
  (
    51,
    '2021-10-28 21:14:29',
    2,
    1,
    15.00,
    0.00,
    198000.00
  ),
  (
    52,
    '2021-10-28 21:31:59',
    2,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    53,
    '2021-10-28 21:35:56',
    2,
    1,
    15.00,
    0.00,
    175000.00
  ),
  (
    54,
    '2021-10-28 21:38:30',
    2,
    1,
    15.00,
    0.00,
    225000.00
  ),
  (
    55,
    '2021-10-28 21:46:48',
    2,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    56,
    '2021-10-28 21:47:51',
    2,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    57,
    '2021-10-28 21:48:12',
    2,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    58,
    '2021-10-28 21:49:32',
    2,
    1,
    15.00,
    0.00,
    144000.00
  ),
  (
    59,
    '2021-10-28 21:54:19',
    2,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    60,
    '2021-10-28 21:54:51',
    2,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    61,
    '2021-10-28 21:56:21',
    2,
    1,
    15.00,
    0.00,
    70000.00
  ),
  (
    62,
    '2021-10-28 21:58:49',
    2,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    63,
    '2021-10-28 21:59:59',
    2,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    64,
    '2021-10-28 22:00:49',
    2,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    65,
    '2021-10-28 22:01:15',
    2,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    66,
    '2021-10-28 22:03:29',
    2,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    67,
    '2021-10-28 22:03:58',
    2,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    68,
    '2021-10-28 22:04:40',
    2,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    69,
    '2021-10-28 22:05:11',
    2,
    1,
    15.00,
    0.00,
    64000.00
  ),
  (
    70,
    '2021-10-28 22:08:17',
    2,
    1,
    15.00,
    0.00,
    45000.00
  ),
  (
    71,
    '2021-10-28 22:08:39',
    2,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    72,
    '2021-10-28 22:09:16',
    2,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    73,
    '2021-10-28 22:12:59',
    1,
    1,
    15.00,
    0.00,
    394000.00
  ),
  (
    74,
    '2021-10-30 09:32:29',
    2,
    1,
    15.00,
    0.00,
    80000.00
  ),
  (
    75,
    '2021-10-30 17:35:38',
    2,
    2,
    15.00,
    0.00,
    112000.00
  ),
  (
    76,
    '2021-10-30 20:12:04',
    1,
    1,
    15.00,
    0.00,
    169000.00
  ),
  (
    77,
    '2021-11-01 14:32:16',
    1,
    1,
    15.00,
    0.00,
    112000.00
  ),
  (
    78,
    '2021-11-01 14:43:43',
    1,
    1,
    15.00,
    0.00,
    122000.00
  ),
  (
    79,
    '2021-11-01 14:44:33',
    2,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    80,
    '2021-11-01 15:41:39',
    2,
    1,
    15.00,
    0.00,
    102000.00
  ),
  (
    81,
    '2021-11-05 21:21:01',
    1,
    1,
    15.00,
    0.00,
    32000.00
  ),
  (
    82,
    '2021-11-05 22:34:41',
    1,
    1,
    15.00,
    0.00,
    115985.00
  ),
  (
    83,
    '2021-11-07 01:17:19',
    1,
    1,
    15.00,
    0.00,
    80000.00
  ),
  (
    84,
    '2021-11-07 20:57:54',
    1,
    1,
    15.00,
    0.00,
    35000.00
  ),
  (
    85,
    '2021-11-08 09:15:33',
    1,
    1,
    15.00,
    0.00,
    403995.00
  ),
  (
    86,
    '2021-11-08 09:16:38',
    6,
    1,
    15.00,
    0.00,
    43995.00
  ),
  (
    87,
    '2021-11-08 14:36:09',
    6,
    1,
    15.00,
    0.00,
    70000.00
  ),
  (
    88,
    '2021-11-08 15:16:55',
    1,
    1,
    15.00,
    0.00,
    75995.00
  ),
  (
    89,
    '2021-11-25 13:55:55',
    1,
    1,
    15.00,
    0.00,
    96000.00
  );
  /*!40000 ALTER TABLE `Ventas` ENABLE KEYS */;
  /*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
  /*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
  /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
  /*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;