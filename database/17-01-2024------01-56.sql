-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-01-2024 a las 19:56:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistemasanidad`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_asistencia` ()   BEGIN
	SELECT idusuario, nombres, apellidos, nombreusuario, ingreso,
		CASE 
			WHEN nivelacceso = "A" THEN "Administrador"
			WHEN nivelacceso = "F" THEN "Farmacia"
			WHEN nivelacceso = "M" THEN "Médico"
		END "nivelacceso", estado, email, codverificacion
	 FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_categoria_cultivo` ()   BEGIN
	SELECT * FROM cultivo ORDER BY cultivo.nombre_cultivo ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_categoria_lote` ()   SELECT * FROM lote 
ORDER BY lote.nombre_lote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_jefe_fundo` ()   SELECT usuarios.idusuario, CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS Nombre
    FROM usuarios
    WHERE usuarios.nivelacceso = 'J'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_s_lotes` (IN `_id_slote` INT)   select * from sub_lote 
INNER JOIN lote on sub_lote.fk_id_lote = lote.id_lote 
WHERE lote.id_lote=_id_slote
ORDER BY sub_lote._slote_nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_variedades` (IN `_id_cultivo` INT)   select * from variedad
	INNER JOIN cultivo ON variedad.id_cultivo = cultivo.id_cultivo
    WHERE cultivo.id_cultivo=_id_cultivo
	order by variedad.nombre_variedad asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_categorias_almacen_cargar` ()   BEGIN
	SELECT * FROM categoria_productos_almacen ORDER BY id_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_categorias_cargar` ()   BEGIN
	SELECT * FROM categorias ORDER BY idcategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_producto` (IN `_idproducto` INT)   BEGIN
		DELETE FROM productos
		WHERE idproducto = _idproducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_producto_sanidad` (IN `_idProducto` INT)   DELETE FROM productos_sanidad
WHERE productos_sanidad.id_producto=_idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_emailnoexiste_registrado` (IN `_email` VARCHAR(50))   BEGIN
	SELECT * FROM usuarios
	WHERE email = _email;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundos_getdata` (IN `_idfundo` INT)   SELECT fundo.id_fundo,fundo.jefe_fundo,fundo.nombre,usuarios.nombres,usuarios.apellidos,fundo.lote,fundo.s_lote,fundo.hectareas,cultivo.nombre_cultivo,variedad.nombre_variedad FROM fundo INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario INNER JOIN cultivo on fundo.cultivo= cultivo.id_cultivo INNER JOIN variedad ON fundo.variedad=variedad.id_variedad
	WHERE fundo.id_fundo = _idfundo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundos_listar` ()   BEGIN
    SELECT fundo.id_fundo,fundo.nombre,usuarios.nombres,usuarios.apellidos,fundo.lote,fundo.s_lote,fundo.hectareas,cultivo.nombre_cultivo,variedad.nombre_variedad FROM fundo 
INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario
INNER JOIN cultivo on fundo.cultivo= cultivo.id_cultivo 
INNER JOIN variedad ON fundo.variedad=variedad.id_variedad
    ORDER BY fundo.nombre ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundoYaRegistrado` (IN `_nombrefundo` VARCHAR(20))   BEGIN
    SELECT * FROM fundo
    WHERE fundo.nombre = _nombrefundo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundo_filtrar_categorias` (IN `_idJefe` INT)   BEGIN
    SELECT fundo.id_fundo,fundo.nombre,usuarios.nombres,usuarios.apellidos,fundo.lote,fundo.s_lote,fundo.hectareas,cultivo.nombre_cultivo,variedad.nombre_variedad FROM fundo INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario INNER JOIN cultivo on fundo.cultivo= cultivo.id_cultivo INNER JOIN variedad ON fundo.variedad=variedad.id_variedad
    WHERE fundo.jefe_fundo=_idJefe;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundo_modificar` (IN `_idfundo` INT, IN `_jefe` INT, IN `_nombre` VARCHAR(30), IN `_lote` VARCHAR(15), IN `_slote` VARCHAR(15), IN `_hec` DOUBLE, IN `_cultivos` INT, IN `_variedad` INT)   UPDATE fundo SET
fundo.jefe_fundo=_jefe,
fundo.nombre=_nombre,
fundo.lote=_lote,
fundo.s_lote=_slote,
fundo.hectareas=_hec,
fundo.cultivo=_cultivos,
fundo.variedad=_variedad
WHERE fundo.id_fundo=_idfundo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundo_registro` (IN `_idcategoria` INT, IN `_nombrefundo` VARCHAR(30), IN `_lote` VARCHAR(15), IN `_slote` VARCHAR(15), IN `_hectareas` DOUBLE, IN `_cultivo` INT, IN `_variedad` INT)   BEGIN
    INSERT INTO fundo(jefe_fundo, nombre,fundo.lote,fundo.s_lote,fundo.hectareas,fundo.cultivo,fundo.variedad) 
    VALUES (_idcategoria, _nombrefundo,_lote,_slote,_hectareas,_cultivo,_variedad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_motivoAplicacion_getdata` (IN `_idmotivo` INT)   SELECT * from motivo_aplicacion
	WHERE motivo_aplicacion.id_motivo=_idmotivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_motivo_aplicacion_listar` ()   SELECT * from motivo_aplicacion 
ORDER BY motivo_aplicacion.nombre_motivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_motivo_aplicacion_modificar` (IN `_idmotivo` INT, IN `_nombremotivo` VARCHAR(30))   UPDATE motivo_aplicacion SET
	motivo_aplicacion.nombre_motivo= _nombremotivo
WHERE motivo_aplicacion.id_motivo=_idmotivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_motivo_aplicacion_registro` (IN `_nombre` VARCHAR(30))   INSERT INTO motivo_aplicacion(motivo_aplicacion.nombre_motivo) VALUES
(_nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_nombreproducto_registrado` (IN `_nombreproducto` VARCHAR(50))   BEGIN
	SELECT * FROM productos
	WHERE nombreproducto = _nombreproducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_nombreproducto_sanidad_registrado` (IN `_nombreproducto` VARCHAR(30))   SELECT * FROM productos_sanidad
WHERE productos_sanidad.nombre_producto=_nombreproducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_nombreusuario_registrado` (IN `_nombreusuario` VARCHAR(25))   BEGIN
	SELECT * FROM usuarios 
	WHERE nombreusuario = _nombreusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_nombre_motivo_aplicacion_registrado` (IN `_nombremotivo` VARCHAR(30))   SELECT * FROM motivo_aplicacion
WHERE motivo_aplicacion.nombre_motivo=_nombremotivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productosalmacen_filtrar_categorias` (IN `_idcategoria` INT)   BEGIN
	SELECT * FROM productos_alamacen 
	INNER JOIN categoria_productos_almacen ON categoria_productos_almacen.id_categoria = productos_alamacen.id_categoria
	WHERE productos_alamacen.id_categoria= _idcategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productosSanidad_getdata` (IN `id_producto` INT)   SELECT * from productos_sanidad
	WHERE productos_sanidad.id_producto=id_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_almacen_registro` (IN `_idcategoria` INT, IN `_nombreproducto` TEXT, IN `_fechavencimiento` DATE, IN `_stock` INT)   BEGIN	
	INSERT INTO productos_alamacen(id_categoria,nom_producto,fecha_vencimiento,stock) VALUES 
			(_idcategoria,_nombreproducto,_fechavencimiento,_stock);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_filtrar_categorias` (IN `_idcategoria` INT)   BEGIN
	SELECT * FROM productos
	INNER JOIN categorias ON categorias.idcategoria = productos.idcategoria
	WHERE productos.idcategoria= _idcategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_getdata` (IN `_idproducto` INT)   BEGIN
	SELECT * FROM productos
	WHERE idproducto = _idproducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_listar` ()   begin
	select * from productos 
	INNER JOIN categorias ON categorias.idcategoria = productos.idcategoria	
	order by fechavencimiento asc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_modificar` (IN `_idproducto` INT, IN `_nombreproducto` TEXT, IN `_principiosactivos` TEXT, IN `_formafarmaceutica` TEXT, IN `_descripcion` TEXT, IN `_fechavencimiento` DATE)   BEGIN
	UPDATE productos SET
	nombreproducto = _nombreproducto,
	principiosactivos = _principiosactivos,
	formafarmaceutica = _formafarmaceutica,
	descripcion = _descripcion,
	fechavencimiento = _fechavencimiento
	WHERE idproducto = _idproducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_registro` (IN `_idcategoria` INT, IN `_nombreproducto` TEXT, IN `_principiosactivos` TEXT, IN `_formafarmaceutica` TEXT, IN `_descripcion` TEXT, IN `_fechavencimiento` DATE)   BEGIN	
	INSERT INTO productos(idcategoria, nombreproducto, principiosactivos, formafarmaceutica, descripcion, fechavencimiento) VALUES 
			(_idcategoria, _nombreproducto, _principiosactivos, _formafarmaceutica, _descripcion, _fechavencimiento);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_sanidad_listar` ()   SELECT * FROM productos_sanidad ORDER BY productos_sanidad.nombre_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_sanidad_modificar` (IN `_idproducto` INT, IN `_codigoproducto` INT, IN `_nombreproducto` VARCHAR(30), IN `_unidad` VARCHAR(10))   UPDATE productos_sanidad SET
productos_sanidad.codigo_producto=_codigoproducto,
productos_sanidad.nombre_producto=_nombreproducto,
productos_sanidad.unidad=_unidad
WHERE productos_sanidad.id_producto=_idproducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_sanidad_registro` (IN `_codigo` INT(11), IN `_nombre` VARCHAR(30), IN `_unidad` VARCHAR(20))   INSERT INTO productos_sanidad(productos_sanidad.codigo_producto,productos_sanidad.nombre_producto,productos_sanidad.unidad) 		VALUES (_codigo,_nombre,_unidad)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_actualizarclave` (IN `_idusuario` INT, IN `_clave` VARCHAR(100))   BEGIN
	UPDATE usuarios SET clave = _clave WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_eliminar` (IN `_idusuario` INT)   BEGIN
	UPDATE usuarios SET
		fechabaja = CURDATE(),
		estado = "I"
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_getdata` (IN `_idusuario` INT)   BEGIN
	SELECT idusuario, nombres, apellidos, nombreusuario, clave, fechacreacion, fechabaja, 
        CASE 
            WHEN nivelacceso = "A" THEN "Administrador"
            WHEN nivelacceso = "C" THEN "Calidad"
            WHEN nivelacceso = "J" THEN "Jefe de Fundo"
            WHEN nivelacceso = "O" THEN "Operario"
            WHEN nivelacceso = "S" THEN "Sanidad"
		END "nivelacceso", estado, email, codverificacion
	 FROM usuarios
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_listar` ()   BEGIN
SELECT idusuario, nombres, apellidos, nombreusuario, clave, fechacreacion, fechabaja,ingreso,
CASE
WHEN nivelacceso = "A" THEN "Administrador"
WHEN nivelacceso = "C" THEN "Calidad"
WHEN nivelacceso = "J" THEN "Jefe de Fundo"
WHEN nivelacceso = "O" THEN "Operario"
WHEN nivelacceso = "S" THEN "Sanidad"
END "nivelacceso", estado, email, codverificacion
FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_login` (IN `_nombreusuario` VARCHAR(25))   BEGIN
SELECT idusuario, nombres, apellidos, nombreusuario, clave, fechacreacion, fechabaja,ingreso,
CASE
WHEN nivelacceso = "A" THEN "Administrador"
WHEN nivelacceso = "C" THEN "Calidad"
WHEN nivelacceso = "J" THEN "Jefe de Fundo"
WHEN nivelacceso = "O" THEN "Operario"
WHEN nivelacceso = "S" THEN "Sanidad"
END "nivelacceso", estado, email, codverificacion
FROM usuarios
WHERE nombreusuario = _nombreusuario AND estado = "A";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_modificar` (IN `_idusuario` INT, IN `_nombreusuario` VARCHAR(25), IN `_nivelacceso` CHAR(1), IN `_email` VARCHAR(50))   BEGIN
	UPDATE usuarios SET
		nombreusuario = _nombreusuario,
		nivelacceso = _nivelacceso,
		email = _email
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_reactivar` (IN `_idusuario` INT)   BEGIN
	UPDATE usuarios SET
		fechacreacion = CURDATE(),
		fechabaja = NULL,
		estado = "A"
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_registro` (IN `_nombres` VARCHAR(50), IN `_apellidos` VARCHAR(50), IN `_nombreusuario` VARCHAR(25), IN `_nivelacceso` CHAR(1), IN `_email` VARCHAR(80))   BEGIN
	INSERT INTO usuarios(nombres, apellidos,nombreusuario, clave, fechacreacion,fechabaja, nivelacceso, estado, email, codverificacion)VALUES
			(_nombres, _apellidos, _nombreusuario, "$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi", CURDATE(), NULL, _nivelacceso, "A", _email, NULL);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuario_codverificacion` (IN `_idusuario` INT, IN `_codverificacion` CHAR(6))   BEGIN 
	UPDATE usuarios SET
		codverificacion = _codverificacion
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuario_eliminarcodverificacion` (IN `_idusuario` INT)   BEGIN 
	UPDATE usuarios SET
		codverificacion = NULL
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuario_verificarcorreo` (IN `_email` VARCHAR(50))   BEGIN	
		SELECT idusuario, CONCAT (apellidos, " ", nombres) AS 'datospersona', nombreusuario, clave, fechacreacion, fechabaja, 
		CASE 
			WHEN nivelacceso = "A" THEN "Administrador"
            WHEN nivelacceso = "C" THEN "Calidad"
            WHEN nivelacceso = "J" THEN "Jefe de Fundo"
            WHEN nivelacceso = "O" THEN "Operario"
            WHEN nivelacceso = "S" THEN "Sanidad"
		END "nivelacceso", estado, email, codverificacion
	 FROM usuarios
	 WHERE email =_email AND estado = "A";
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id_fecha` int(11) NOT NULL,
  `fecha_des` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia` (`id_fecha`, `fecha_des`) VALUES
(1, '2024-01-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `idcategoria` int(11) NOT NULL,
  `categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`idcategoria`, `categoria`) VALUES
(5, 'Analgésicos y antiinflamatorios - Aines solos y co'),
(8, 'Antiacidos y Protectores gastricos'),
(4, 'Antibioticos'),
(1, 'Anticatarrales'),
(18, 'Anticonceptivos y hormonales'),
(17, 'Antiespasmódicos'),
(3, 'Antihistaminicos'),
(19, 'Antimicótico y antifúngicas'),
(7, 'Antiparasitario'),
(12, 'Cardiovasculares'),
(2, 'Fluidificantes, antiasmáticos y antitusígenos'),
(11, 'Gastrointestinal'),
(10, 'Inhaladores'),
(15, 'Otros'),
(13, 'Psicofarmacos'),
(6, 'Tratamentiento para colesterol y trigliseridos'),
(16, 'Tratamiento genitorurinario'),
(14, 'Tratamiento para diabetes'),
(9, 'Vitaminas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cultivo`
--

CREATE TABLE `cultivo` (
  `id_cultivo` int(11) NOT NULL,
  `nombre_cultivo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cultivo`
--

INSERT INTO `cultivo` (`id_cultivo`, `nombre_cultivo`) VALUES
(1, 'Vid'),
(4, 'Granada'),
(5, 'Citrico'),
(6, 'Arandano'),
(10, 'Esparrago');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fundo`
--

CREATE TABLE `fundo` (
  `id_fundo` int(11) NOT NULL,
  `jefe_fundo` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `lote` varchar(15) NOT NULL,
  `s_lote` varchar(15) NOT NULL,
  `hectareas` double(7,2) NOT NULL,
  `cultivo` int(11) NOT NULL,
  `variedad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fundo`
--

INSERT INTO `fundo` (`id_fundo`, `jefe_fundo`, `nombre`, `lote`, `s_lote`, `hectareas`, `cultivo`, `variedad`) VALUES
(72, 16, 'Santa Margarita', '1118-7', '7', 17.00, 1, 1),
(73, 16, 'Santa Margarita', '1118-8', '8', 21.00, 1, 1),
(74, 16, 'Santa Margarita', '1122-9A', '9A', 21.03, 1, 1),
(75, 16, 'Santa Margarita', '1124-9B', '9B', 7.87, 1, 1),
(76, 17, 'Santa Margarita', '1125-4', '4', 8.80, 1, 1),
(77, 17, 'Santa Margarita', '1116-2', '2', 18.64, 1, 1),
(78, 17, 'Santa Margarita', '1116-1', '1', 17.41, 1, 1),
(79, 17, 'Santa Margarita', '1125-6.4', '6.4', 11.65, 1, 1),
(80, 18, 'Santa Margarita', '1126-3', '3', 25.78, 1, 1),
(81, 18, 'Santa Margarita', '1123-5', '7', 26.72, 1, 1),
(82, 18, 'Santa Margarita', '1127', '1127', 5.06, 1, 1),
(83, 19, 'Santa Margarita', '1610', '1610', 9.30, 1, 1),
(84, 19, 'Santa Margarita', '1117-6.1', '6.1', 21.03, 1, 1),
(85, 19, 'Santa Margarita', '1117-6.2', '6.2', 17.67, 1, 1),
(86, 19, 'Santa Margarita', '1117-6.3', '6.3', 15.73, 1, 1),
(87, 20, 'SAN HILARION', '1204-6', '6', 6.36, 1, 2),
(88, 20, 'SAN HILARION', '1204-7B', '7B', 8.76, 1, 2),
(89, 20, 'SAN HILARION', '1204-7A', '7A', 8.65, 1, 2),
(90, 20, 'SAN HILARION', '1203-1', '1', 4.05, 1, 2),
(91, 20, 'SAN HILARION', '1203-2', '2', 8.54, 1, 2),
(92, 20, 'SAN HILARION', '1203-3', '3', 3.33, 1, 2),
(93, 20, 'SAN HILARION', '1203-4', '4', 7.57, 1, 2),
(94, 20, 'SAN HILARION', '1203-5', '5', 3.63, 1, 2),
(95, 21, 'PROYECTO VID SANTA MARGARITA', '1150', '1150', 40.00, 1, 2),
(96, 21, 'PROYECTO VID SANTA MARGARITA', '1151', '1151', 25.00, 1, 4),
(97, 22, 'Santa Esperanza', '5515', '5515', 0.96, 1, 4),
(98, 22, 'Santa Esperanza', '5516', '5516', 1.02, 1, 5),
(99, 22, 'Santa Esperanza', '5517', '5517', 8.51, 1, 6),
(100, 22, 'Santa Esperanza', '5518', '5518', 1.02, 1, 2),
(101, 22, 'Santa Esperanza', '5519', '5519', 1.02, 1, 8),
(102, 22, 'Santa Esperanza', '1515', '1515', 23.24, 5, 16),
(103, 22, 'Santa Esperanza', '1516', '1516', 7.00, 5, 16),
(104, 22, 'Santa Esperanza', '1517', '1517', 3.20, 5, 16),
(105, 23, 'Santa Esperanza', '1130', '1130', 10.00, 5, 17),
(106, 23, 'Santa Esperanza', '1160', '1160', 66.19, 5, 16),
(107, 23, 'Santa Esperanza', '1710', '1710', 27.19, 5, 16),
(108, 24, 'SANTA LUCIA', '5701', 'A', 8.50, 4, 18),
(109, 24, 'SANTA LUCIA', '5701', 'B', 12.62, 4, 18),
(110, 24, 'SANTA LUCIA', '5702', 'A', 10.27, 4, 18),
(111, 24, 'SANTA LUCIA', '5702', 'B', 11.21, 4, 18),
(112, 24, 'SANTA LUCIA', '5703', 'A', 8.36, 4, 18),
(113, 24, 'SANTA LUCIA', '5703', 'B', 9.00, 4, 18),
(114, 25, 'DOS MARIAS', '5401', '5401', 44.00, 6, 19),
(115, 26, 'DOS MARIAS', '5402', '5402', 54.41, 6, 19),
(116, 27, 'DOS MARIAS', '5403', '5403', 55.45, 6, 19),
(117, 25, 'DOS MARIAS', '5404', '5404', 20.59, 6, 19),
(118, 25, 'DOS MARIAS', '5404', '5404', 0.80, 6, 20),
(119, 28, 'SANTA INES', '5810', '5810', 72.40, 6, 19),
(120, 28, 'SANTA INES', '5810', '5810', 0.20, 6, 20),
(121, 27, 'SANTA ISABEL', '6301', '6301', 12.00, 6, 19),
(122, 29, 'SAN ISIDRO LABRADOR', '1802', '1802', 20.50, 10, 21),
(123, 29, 'LUREN', '1306', '1306', 8.00, 10, 22),
(124, 29, 'FORTUNA', '1901', '1901', 47.00, 10, 21),
(125, 29, 'SANTA CARLA', '5901', '5901', 10.87, 10, 21),
(126, 29, 'GLORIA', '5601', '5601', 11.35, 10, 21),
(127, 29, 'GLORIA', '5602', '5602', 1.80, 10, 21),
(128, 24, 'SANTA LUCIA', '5710', '5710', 11.30, 10, 21),
(129, 29, 'ALPINE 511', '3111', '3111', 26.50, 10, 21),
(130, 29, 'ALPINE 511', '3112', '3112', 41.50, 10, 23),
(131, 29, 'ALPINE PERU', '3101', '3101', 33.00, 10, 24),
(132, 29, 'ALPINE PERU', '3102', '3102', 14.00, 10, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lote`
--

CREATE TABLE `lote` (
  `id_lote` int(11) NOT NULL,
  `nombre_lote` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lote`
--

INSERT INTO `lote` (`id_lote`, `nombre_lote`) VALUES
(1, '1118-7'),
(2, '1118-8'),
(3, '1122-9A'),
(4, '1124-9B'),
(5, '1125-4'),
(6, '1116-2'),
(7, '1116-1'),
(8, '1125-6.4'),
(9, '1126-3'),
(10, '1123-5'),
(11, '1127'),
(12, '1610'),
(13, '1117-6.1'),
(14, '1117-6.2'),
(15, '1117-6.3'),
(16, '1204-6'),
(17, '1204-7B'),
(18, '1204-7A'),
(19, '1203-1'),
(20, '1203-2'),
(21, '1203-3'),
(22, '1203-4'),
(23, '1203-5'),
(24, '1150'),
(25, '1151'),
(26, '5515'),
(27, '5516'),
(28, '5517'),
(29, '5518'),
(30, '5519'),
(31, '1515'),
(32, '1516'),
(33, '1517'),
(34, '1130'),
(35, '1160'),
(36, '1710'),
(37, '5701'),
(38, '5702'),
(39, '5703'),
(40, '5401'),
(41, '5402'),
(42, '5403'),
(43, '5404'),
(44, '5810'),
(45, '6301'),
(46, '1802'),
(47, '1306'),
(48, '1901'),
(49, '5901'),
(50, '5601'),
(51, '5602'),
(52, '5710'),
(53, '3111'),
(54, '3112'),
(55, '3101'),
(56, '3102');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivo_aplicacion`
--

CREATE TABLE `motivo_aplicacion` (
  `id_motivo` int(11) NOT NULL,
  `nombre_motivo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `motivo_aplicacion`
--

INSERT INTO `motivo_aplicacion` (`id_motivo`, `nombre_motivo`) VALUES
(8, 'COLOR'),
(9, 'TRIPS'),
(10, 'LARVAS LEPIDOPTEROS'),
(11, 'FOLIAR'),
(12, 'CHANCHITO BLANCO'),
(13, 'OIDIUM'),
(14, 'BOTRYTIS'),
(15, 'MILDIU'),
(16, 'CRECIMIENTO DE BAYA'),
(17, 'RALEO QUIMICO'),
(18, 'ACARO'),
(19, 'CONTROL DE MALEZAS'),
(20, 'CONTROL DE NEMATODOS'),
(21, 'PUDRICION'),
(22, 'HONGO DE MADERA'),
(23, 'MADURACION'),
(24, 'BRIX');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idproducto` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `nombreproducto` text NOT NULL,
  `principiosactivos` text NOT NULL,
  `formafarmaceutica` text NOT NULL,
  `descripcion` text NOT NULL,
  `fechavencimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idproducto`, `idcategoria`, `nombreproducto`, `principiosactivos`, `formafarmaceutica`, `descripcion`, `fechavencimiento`) VALUES
(505, 6, '<p>a</p>', '<p>a</p>', '<p>a</p>', '<p>a</p>', '2024-02-03'),
(506, 4, '<p>av</p>', '<p>a</p>', '<p>a</p>', '<p>a</p>', '2024-02-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_sanidad`
--

CREATE TABLE `productos_sanidad` (
  `id_producto` int(11) NOT NULL,
  `codigo_producto` int(11) NOT NULL,
  `nombre_producto` varchar(30) NOT NULL,
  `unidad` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_sanidad`
--

INSERT INTO `productos_sanidad` (`id_producto`, `codigo_producto`, `nombre_producto`, `unidad`) VALUES
(10, 14040845, 'ABSOLUTE 60 SC', 'L'),
(11, 14091375, 'ACAPROX', 'L'),
(12, 14025861, 'ACARSTIN', 'L'),
(13, 14014888, 'ACIDO CITRICO', 'KG'),
(14, 14032938, 'ACTARA 25W', 'KG'),
(15, 14092427, 'ACTIVOL 40 SG', 'KG'),
(16, 14090187, 'AGRIBEST', 'L'),
(17, 14092360, 'AGRIOIL 99 SL', 'L'),
(18, 14092859, 'ALEXIN PA 100 BT ENZYM LIQUIDO', 'L'),
(19, 14011770, 'ALIETTE', 'KG'),
(20, 14091935, 'AMAUTA 240 SL', 'L'),
(21, 14046562, 'AMINOLOM VITAMIN', 'L'),
(22, 14070340, 'AMINOTERRA', 'L'),
(23, 14056195, 'AMIPRID 20 SP', 'KG'),
(24, 14029701, 'AMISTAR 50 WG', 'KG'),
(25, 14042244, 'ANTI-D', 'L'),
(26, 14029655, 'AZUFRE POLVO MOJABLE', 'KG'),
(27, 14087449, 'BASFOLIAR SIZE', 'L'),
(28, 14000022, 'BAYFOLAN', 'L'),
(29, 14033305, 'BC-1000 LIQUIDO', 'L'),
(30, 14036935, 'BELLIS W G', 'KG'),
(31, 14011777, 'BENOPOINT', 'KG'),
(32, 14084506, 'BIOCINN', 'L'),
(33, 14066810, 'BIOCRECE', 'L'),
(34, 14090723, 'BIO-FORGE', 'L'),
(35, 14087819, 'BIOKARANYA', 'L'),
(36, 14088781, 'BIONEMAX (NEMATODOS X 15 MILLO', 'BOL'),
(37, 14000024, 'BIOPLUS', 'L'),
(38, 14084683, 'BIO-SPLENT 70WP', 'KG'),
(39, 14045258, 'BIOSPORE 6.4% PM', 'KG'),
(40, 14091742, 'BOTRYCCELLI', 'L'),
(41, 14084920, 'BRIX UP', 'L'),
(42, 14038236, 'BT-NOVA WP', 'KG'),
(43, 14042089, 'CALBO', 'L'),
(44, 14057842, 'CALCIO FORTE', 'L'),
(45, 14038415, 'CANTUS', 'KG'),
(46, 14023680, 'CARBOXY K', 'L'),
(47, 14057062, 'CARBOXY K X 208 L.', 'L'),
(48, 14031433, 'CARBOXY MG', 'L'),
(49, 14061953, 'CARBOXYL L X 208 L.', 'L'),
(50, 14034842, 'CENTURION', 'L'),
(51, 14091350, 'CHALANGO 250 SC', 'L'),
(52, 14041132, 'CLORFOS 48 CE', 'L'),
(53, 14082551, 'CLOSER 240 SC', 'L'),
(54, 14088396, 'COLUMBUS', 'L'),
(55, 14012501, 'CONFIDOR 350 SC', 'L'),
(56, 14084354, 'CONFIEE 325 SC', 'L'),
(57, 14085714, 'CRESCAL FE', 'KG'),
(58, 14084081, 'CRISURON', 'KG'),
(59, 14024422, 'CROP+', 'L'),
(60, 14056554, 'CROPFIELD AMINO', 'L'),
(61, 14091334, 'CROPS ZINC', 'L'),
(62, 14000040, 'CUNEB FORTE', 'L'),
(63, 14011781, 'CUPRAVIT OB', 'KG'),
(64, 14090510, 'CUSTOMBIO B5', 'L'),
(65, 14054782, 'CYTOKIN', 'L'),
(66, 14012505, 'DECIS 2.5 EC', 'L'),
(67, 14050184, 'DELTOX', 'L'),
(68, 14054860, 'DIFECON 250 EC', 'L'),
(69, 14067860, 'DITHANE FMB', 'L'),
(70, 14055050, 'DK-ESCALON', 'L'),
(71, 14035662, 'DK-TINA', 'L'),
(72, 14087709, 'DK-ZATE', 'KG'),
(73, 14078544, 'ELIPHOS', 'L'),
(74, 14086458, 'EN VIVO SC', 'L'),
(75, 14038864, 'ENERGYPHOS', 'KG'),
(76, 14019798, 'ENVIDOR 240 SC', 'L'),
(77, 14058937, 'EPICO 750 WG', 'KG'),
(78, 14040580, 'ERRASER 757', 'KG'),
(79, 14090758, 'FARMATHE', 'KG'),
(80, 14012514, 'FENKIL 3%', 'KG'),
(81, 14055229, 'FENKIL 500 EC', 'L'),
(82, 14069439, 'FEROMONA DEL BARRENADOR DE RUE', 'UN'),
(83, 14088326, 'FERTUM BOOSTER', 'L'),
(84, 14000050, 'FITOAMIN', 'L'),
(85, 14012492, 'FITOBROT', 'L'),
(86, 14067776, 'FITOKLIN', 'KG'),
(87, 14090266, 'FLEXITY', 'KG'),
(88, 14080243, 'FLUAZIL B40  EC', 'L'),
(89, 14029915, 'FOLUR', 'L'),
(90, 14011547, 'FOSFATO MONOAMONICO SOLUBLE', 'KG'),
(91, 14092403, 'FULBETA PLUS', 'L'),
(92, 14049190, 'FULLPACK', 'L'),
(93, 14066754, 'GRANFURAN', 'L'),
(94, 14062179, 'GREEN MAGNESIO', 'L'),
(95, 14091218, 'GROWS-CYT', 'L'),
(96, 14085159, 'HONGOS PAECILOMYCES LILACINUS', 'KG'),
(97, 14030089, 'HORMONA DK GIB TAB', 'UN'),
(98, 14023166, 'HUNTER', 'L'),
(99, 14086890, 'HURAKAN', 'L'),
(100, 14092423, 'IDAI COBRE', 'L'),
(101, 14087451, 'IKARO', 'KG'),
(102, 14064056, 'JAKE 200 SL', 'L'),
(103, 14089021, 'KADONDO-AG', 'KG'),
(104, 14000065, 'KAMAB 26', 'KG'),
(105, 14050387, 'KARBOXYLATO DE POTASIO', 'L'),
(106, 14089884, 'KATSU 5% EW', 'L'),
(107, 14088740, 'KELMAX', 'L'),
(108, 14032674, 'KELPAK', 'L'),
(109, 14012528, 'KLERAT PELLET', 'KG'),
(110, 14045867, 'K-ÑON', 'L'),
(111, 14044011, 'KOLBRIX', 'L'),
(112, 14090550, 'KUARTEL', 'L'),
(113, 14064300, 'LEPIBAC 10 PM', 'KG'),
(114, 14090935, 'L-ESPECIALISTA 230 SC', 'L'),
(115, 14089086, 'MASADA 48 SC', 'L'),
(116, 14091936, 'MATICIN 240 SL', 'L'),
(117, 14020516, 'MELAZA DE CAÑA', 'KG'),
(118, 14084022, 'MENTOR 750 WG', 'KG'),
(119, 14045120, 'MERTECT 500 SC', 'L'),
(120, 14088453, 'METARRANCH MZ 58 WP', 'KG'),
(121, 14088892, 'METHA-CONTROL', 'KG'),
(122, 14033980, 'METHOMYL', 'KG'),
(123, 14012539, 'MICROTHIOL SPECIAL', 'KG'),
(124, 14065786, 'MOVAXION', 'L'),
(125, 14047738, 'MOVENTO', 'L'),
(126, 14011552, 'NATURAMIN PLUS', 'L'),
(127, 14011553, 'NATURAMIN ZINC', 'L'),
(128, 14089495, 'NATURMIX-L', 'L'),
(129, 14059552, 'NIM 700', 'L'),
(130, 14084430, 'NIMROD', 'L'),
(131, 14011798, 'NISSORUN 10% WP', 'KG'),
(132, 14025267, 'NITRATE BALANCER', 'L'),
(133, 14011554, 'NITRATO DE AMONIO', 'KG'),
(134, 14011555, 'NITRATO DE CALCIO', 'KG'),
(135, 14011556, 'NITRATO DE MAGNESIO', 'KG'),
(136, 14011557, 'NITRATO DE POTASIO CRISTALIZAD', 'KG'),
(137, 14041937, 'NU FILM', 'L'),
(138, 14040962, 'NUTRI CALCIO', 'L'),
(139, 14040961, 'NUTRI MAGNESIO', 'L'),
(140, 14070476, 'PACKHARD', 'L'),
(141, 14069437, 'PANTERA DETER AP35', 'L'),
(142, 14066462, 'PANTERA OIL VEGETAL', 'L'),
(143, 14029143, 'PANTERA PROCESADO', 'KG'),
(144, 14011803, 'PHYTON - 27', 'L'),
(145, 14028806, 'POLYRAM DF', 'KG'),
(146, 14000090, 'PREP 720', 'L'),
(147, 14078543, 'PRIX', 'L'),
(148, 14049046, 'PRO PHYT', 'L'),
(149, 14087032, 'PROPERTY 300 SC', 'L'),
(150, 14018732, 'PROSPER 500 EC', 'L'),
(151, 14043318, 'PROTONE 10 SL', 'L'),
(152, 14086647, 'PYRINEX 48 EC', 'L'),
(153, 14088582, 'QUELA-MAN', 'L'),
(154, 14088587, 'QUELA-ZINC', 'L'),
(155, 14086940, 'RANKILL 500', 'L'),
(156, 14079751, 'RANMAN', 'L'),
(157, 14089082, 'RAYKAT ENRAIZADOR', 'L'),
(158, 14052814, 'ROOTCHEM', 'L'),
(159, 14027482, 'ROOTING', 'L'),
(160, 14055546, 'RYZOFIT', 'L'),
(161, 14086391, 'SANIX PLUS', 'KG'),
(162, 14057090, 'SANTIMEC', 'L'),
(163, 14021895, 'SCORE 250 EC', 'L'),
(164, 14091349, 'SEGURITE 625 WG', 'KG'),
(165, 14045455, 'SELECRON 500 EC', 'L'),
(166, 14022851, 'SETT FIX', 'L'),
(167, 14037335, 'SIAPTON', 'L'),
(168, 14051749, 'SINES-3 MADUREX', 'KG'),
(169, 14063384, 'SKIRLA', 'KG'),
(170, 14000098, 'SOLUBOR', 'KG'),
(171, 14090779, 'SPECIAL', 'L'),
(172, 14069592, 'SPEEDFOL COLOUR', 'KG'),
(173, 14075810, 'SPEEDFOL PECANO', 'KG'),
(174, 14058877, 'SPIROSIL 250 SC', 'L'),
(175, 14040953, 'STRONSIL 50 WG', 'KG'),
(176, 14044813, 'SUCCESSOR SC', 'L'),
(177, 14011562, 'SULFATO DE CU', 'KG'),
(178, 14011564, 'SULFATO DE MAGNESIO CRISTALIZA', 'KG'),
(179, 14011567, 'SULFATO DE POTASIO SOLUBLE', 'KG'),
(180, 14011569, 'SULFATO DE ZINC', 'KG'),
(181, 14086116, 'SULFLIQ', 'L'),
(182, 14011814, 'SULFODIN', 'KG'),
(183, 14089493, 'SULMAT 480 EC', 'L'),
(184, 14090281, 'SUPER POTASIO', 'L'),
(185, 14062720, 'SUPER-A 450 EC', 'L'),
(186, 14088072, 'SURROUND WP', 'KG'),
(187, 14048226, 'SWITCH 62.5 WG', 'KG'),
(188, 14056792, 'SYSTEMIC', 'L'),
(189, 14078546, 'TELDOR SC', 'L'),
(190, 14043262, 'TEMO-O-CID', 'L'),
(191, 14040232, 'TENAZ 250 EW', 'L'),
(192, 14023293, 'TERRASORB FOLIAR', 'L'),
(193, 14063732, 'THIDIAZURON 50 % WP', 'KG'),
(194, 14081840, 'TOPSIL 150 SC', 'L'),
(195, 14090938, 'TOVLI 20 SL', 'L'),
(196, 14023727, 'TRACER 120 SC', 'L'),
(197, 14084078, 'TRECKER', 'KG'),
(198, 14091041, 'T-REX 360 SL', 'L'),
(199, 14011819, 'TRIFMINE 30% PMB', 'KG'),
(200, 14083153, 'TRITEK', 'L'),
(201, 14032841, 'TRIUNFO', 'KG'),
(202, 14011571, 'UREA', 'KG'),
(203, 14085117, 'VAPOR GARD', 'L'),
(204, 14011820, 'VERTIMEC', 'L'),
(205, 14011822, 'VYDAN', 'L'),
(206, 14086650, 'XTEND', 'KG'),
(207, 14084385, 'ZAMPRO DM', 'L'),
(208, 14011573, 'ZIFERMAN', 'L'),
(209, 14088999, 'ZORVEC ENCANTIA', 'L'),
(210, 14012559, 'SUPERMILL 90 PS', 'KG'),
(211, 14024742, 'TIFON 2.5 % PS', 'KG'),
(212, 14090004, 'BASFOLIAR ZN PREMIUM SL', 'L'),
(213, 14091583, 'INVELOP', 'KG'),
(214, 14089034, 'RITMO', 'L'),
(215, 14085464, 'METHOMYL 90% SP', 'KG'),
(216, 14000053, 'GF-120', 'L'),
(217, 14043221, 'TRAMPAS MC JAKSON', 'UN'),
(218, 14075125, 'CERATRAP', 'L'),
(219, 14087886, 'MOSQUERO CONETRAP', 'UN'),
(220, 14091444, 'TRAMPA MCPHALL-30', 'UN'),
(221, 14092108, 'TRYPACK', 'UN'),
(222, 14092693, 'TML PLUG (FEROMONE TRIMEDLURE)', 'UN'),
(223, 14017233, 'BIOLURE', 'UN'),
(224, 14092335, 'CHECKMATE VMB-XL (BALDE X 1000', 'UN'),
(225, 14064016, 'GOLDEN NATURAL OIL', 'L'),
(226, 14070843, 'LAMINA PEGANTE AMARILLA-JACKSO', 'UN'),
(227, 14011812, 'SULCOPENTA', 'L'),
(228, 14064860, 'ACARISIL 110 SC', 'L'),
(229, 14034427, 'HUMICOP', 'L'),
(230, 14081894, 'KOLTAR SC', 'L'),
(231, 14092334, 'GALIGAN 240 EC', 'L'),
(232, 14087723, 'CROPS-CANELA', 'L'),
(233, 14024730, 'AGROCIMAX PLUS', 'L'),
(234, 14089029, 'AMINO Q-S', 'L'),
(235, 14089797, 'STIMPLEX - G', 'L'),
(236, 14076143, 'KALIGREEN', 'KG'),
(237, 14089360, 'TRICHO CONTROL', 'KG');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_lote`
--

CREATE TABLE `sub_lote` (
  `id_sub_lote` int(11) NOT NULL,
  `_slote_nombre` varchar(15) NOT NULL,
  `fk_id_lote` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sub_lote`
--

INSERT INTO `sub_lote` (`id_sub_lote`, `_slote_nombre`, `fk_id_lote`) VALUES
(57, '1', 1),
(58, '2', 2),
(59, '9A', 3),
(60, '9B', 4),
(61, '4', 5),
(62, '2', 6),
(63, '1', 7),
(64, '6.4', 8),
(65, '3', 9),
(66, '7', 10),
(67, '1127', 11),
(68, '1610', 12),
(69, '6.1', 13),
(70, '6.2', 14),
(71, '6.3', 15),
(72, '6', 16),
(73, '7B', 17),
(74, '7A', 18),
(75, '1', 19),
(76, '2', 20),
(77, '3', 21),
(78, '4', 22),
(79, '5', 23),
(80, '1150', 24),
(81, '1151', 25),
(82, '5515', 26),
(83, '5516', 27),
(84, '5517', 28),
(85, '5518', 29),
(86, '5519', 30),
(87, '1515', 31),
(88, '1516', 32),
(89, '1517', 33),
(90, '1130', 34),
(91, '1160', 35),
(92, '1710', 36),
(93, 'A', 37),
(94, 'B', 37),
(95, 'A', 38),
(96, 'B', 38),
(97, 'A', 39),
(98, 'B', 39),
(99, '5401', 40),
(100, '5402', 41),
(101, '5403', 42),
(102, '5404', 43),
(104, '5810', 44),
(106, '6301', 45),
(107, '1802', 46),
(108, '1306', 47),
(109, '1901', 48),
(110, '5901', 49),
(111, '5601', 50),
(112, '5602', 51),
(113, '5710', 52),
(114, '3111', 53),
(115, '3112', 54),
(116, '3101', 55),
(117, '3102', 56);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL,
  `nombres` varchar(70) NOT NULL,
  `apellidos` varchar(70) NOT NULL,
  `nombreusuario` varchar(25) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `fechacreacion` date NOT NULL,
  `fechabaja` date DEFAULT NULL,
  `nivelacceso` char(1) NOT NULL,
  `estado` char(1) NOT NULL,
  `email` varchar(50) NOT NULL,
  `codverificacion` char(6) DEFAULT NULL,
  `ingreso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `nombres`, `apellidos`, `nombreusuario`, `clave`, `fechacreacion`, `fechabaja`, `nivelacceso`, `estado`, `email`, `codverificacion`, `ingreso`) VALUES
(13, 'Administrador', 'Administrador', 'Administrador', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-10', NULL, 'A', 'A', 'admin@admin.com', NULL, 18),
(16, 'Amadeo', 'Acuña', 'aacuña', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(17, 'Roberto', 'Bernales', 'rbernales', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(18, 'Roque', 'Sifuentes', 'rsifuentes', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(19, 'Silverio', 'Ccoyori', 'sccoyori', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(20, 'Gary', 'Trujillo', 'gtrujillo', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(21, 'Miguel', 'Deunis', 'mdeunis', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(22, 'Fernando', 'Cabrera', 'fcabrera', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(23, 'Javier', 'Medina', 'jmedina', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(24, 'Rony', 'Laura', 'rlaura', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(25, 'Karina', 'Torres', 'ktorres', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(26, 'Eder', 'Razabal', 'erazabal', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(27, 'Ricardo', 'Velarde', 'rvelarde', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(28, 'Miguel', 'Vallardares', 'mvallardares', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(29, 'Gino', 'Rosas', 'grosas', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', 'uva1s@beta.com', NULL, 0),
(31, 'Sanidad', 'Sanidad', 'Sanidad', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-17', NULL, 'S', 'A', 'uva1s@beta.com', NULL, 0),
(32, 'Operario', 'Operario', 'Operario', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-17', NULL, 'O', 'A', 'uva1s@beta.com', NULL, 0),
(33, 'Calidad', 'Calidad', 'Calidad', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-17', NULL, 'C', 'A', 'uva1s@beta.com', NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variedad`
--

CREATE TABLE `variedad` (
  `id_variedad` int(11) NOT NULL,
  `nombre_variedad` varchar(30) NOT NULL,
  `id_cultivo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `variedad`
--

INSERT INTO `variedad` (`id_variedad`, `nombre_variedad`, `id_cultivo`) VALUES
(1, 'Red Globe', 1),
(2, 'Sweet Globe', 1),
(4, 'Uva Allison', 1),
(5, 'Uva Ivory', 1),
(6, 'Uva Tinco', 1),
(8, 'Uva Sweet celebration', 1),
(16, 'Murcott', 5),
(17, 'Tango', 5),
(18, 'Wanderson', 4),
(19, 'Ventura', 6),
(20, 'Sekoya', 6),
(21, 'UC 157', 10),
(22, 'Atlas', 10),
(23, 'UC 158', 10),
(24, 'UC 159', 10),
(25, 'UC 160', 10);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_listar_productos_farmacia`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_listar_productos_farmacia` (
`idproducto` int(11)
,`nombreproducto` text
,`categoria` varchar(50)
,`principiosactivos` text
,`formafarmaceutica` text
,`descripcion` text
,`fechavencimiento` date
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_listar_productos_farmacia`
--
DROP TABLE IF EXISTS `vista_listar_productos_farmacia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_listar_productos_farmacia`  AS SELECT `productos`.`idproducto` AS `idproducto`, `productos`.`nombreproducto` AS `nombreproducto`, `categorias`.`categoria` AS `categoria`, `productos`.`principiosactivos` AS `principiosactivos`, `productos`.`formafarmaceutica` AS `formafarmaceutica`, `productos`.`descripcion` AS `descripcion`, `productos`.`fechavencimiento` AS `fechavencimiento` FROM (`productos` join `categorias` on(`categorias`.`idcategoria` = `productos`.`idcategoria`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id_fecha`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `uk_categoria_cat` (`categoria`);

--
-- Indices de la tabla `cultivo`
--
ALTER TABLE `cultivo`
  ADD PRIMARY KEY (`id_cultivo`);

--
-- Indices de la tabla `fundo`
--
ALTER TABLE `fundo`
  ADD PRIMARY KEY (`id_fundo`),
  ADD KEY `jefe_fundo` (`jefe_fundo`),
  ADD KEY `cultivo` (`cultivo`),
  ADD KEY `variedad` (`variedad`);

--
-- Indices de la tabla `lote`
--
ALTER TABLE `lote`
  ADD PRIMARY KEY (`id_lote`);

--
-- Indices de la tabla `motivo_aplicacion`
--
ALTER TABLE `motivo_aplicacion`
  ADD PRIMARY KEY (`id_motivo`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idproducto`),
  ADD KEY `fk_idcategoria_prod` (`idcategoria`);

--
-- Indices de la tabla `productos_sanidad`
--
ALTER TABLE `productos_sanidad`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `sub_lote`
--
ALTER TABLE `sub_lote`
  ADD PRIMARY KEY (`id_sub_lote`),
  ADD KEY `id_lote` (`fk_id_lote`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `uk_nombreusuario_user` (`nombreusuario`);

--
-- Indices de la tabla `variedad`
--
ALTER TABLE `variedad`
  ADD PRIMARY KEY (`id_variedad`),
  ADD KEY `id_cultivo` (`id_cultivo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id_fecha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `cultivo`
--
ALTER TABLE `cultivo`
  MODIFY `id_cultivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `fundo`
--
ALTER TABLE `fundo`
  MODIFY `id_fundo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT de la tabla `lote`
--
ALTER TABLE `lote`
  MODIFY `id_lote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT de la tabla `motivo_aplicacion`
--
ALTER TABLE `motivo_aplicacion`
  MODIFY `id_motivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=507;

--
-- AUTO_INCREMENT de la tabla `productos_sanidad`
--
ALTER TABLE `productos_sanidad`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT de la tabla `sub_lote`
--
ALTER TABLE `sub_lote`
  MODIFY `id_sub_lote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `variedad`
--
ALTER TABLE `variedad`
  MODIFY `id_variedad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `fundo`
--
ALTER TABLE `fundo`
  ADD CONSTRAINT `fundo_ibfk_1` FOREIGN KEY (`jefe_fundo`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fundo_ibfk_2` FOREIGN KEY (`cultivo`) REFERENCES `cultivo` (`id_cultivo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fundo_ibfk_3` FOREIGN KEY (`variedad`) REFERENCES `variedad` (`id_variedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_idcategoria_prod` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`idcategoria`);

--
-- Filtros para la tabla `sub_lote`
--
ALTER TABLE `sub_lote`
  ADD CONSTRAINT `sub_lote_ibfk_1` FOREIGN KEY (`fk_id_lote`) REFERENCES `lote` (`id_lote`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `variedad`
--
ALTER TABLE `variedad`
  ADD CONSTRAINT `variedad_ibfk_1` FOREIGN KEY (`id_cultivo`) REFERENCES `cultivo` (`id_cultivo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
