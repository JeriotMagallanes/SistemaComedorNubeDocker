-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-01-2024 a las 05:22:16
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
            WHEN nivelacceso = "C" THEN "Calidad"
            WHEN nivelacceso = "J" THEN "Jefe de Fundo"
            WHEN nivelacceso = "O" THEN "Operario"
            WHEN nivelacceso = "S" THEN "Sanidad"
		END "nivelacceso", estado, email, codverificacion
	 FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_categoria_cultivo` ()   BEGIN
	SELECT * FROM cultivo ORDER BY cultivo.nombre_cultivo ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_categoria_lote` ()   SELECT * FROM lote 
ORDER BY lote.nombre_lote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_cultivos_lotes` (IN `_id_slote` INT)   SELECT sub_lote.id_sub_lote,sub_lote._slote_nombre,cultivo.id_cultivo, cultivo.nombre_cultivo from fundo INNER JOIN sub_lote ON fundo.s_lote=sub_lote.id_sub_lote INNER JOIN cultivo ON fundo.cultivo=cultivo.id_cultivo WHERE sub_lote.id_sub_lote=_id_slote
GROUP BY cultivo.nombre_cultivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_jefe_fundo` ()   SELECT usuarios.idusuario, CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS Nombre
    FROM usuarios
    WHERE usuarios.nivelacceso = 'J'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_lote_nombreFundo` (IN `_nombreFundo` VARCHAR(30), IN `_idjefe` INT)   SELECT fundo.nombre, lote.id_lote,lote.nombre_lote from fundo
INNER JOIN lote ON 
fundo.lote= lote.id_lote
WHERE fundo.nombre=_nombreFundo and fundo.jefe_fundo=_idjefe
GROUP BY lote.id_lote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_nombre_fundos` (IN `_idjefe` INT)   SELECT * FROM fundo 
WHERE fundo.jefe_fundo=_idjefe 
GROUP BY fundo.nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_s_lotes` (IN `_id_slote` INT)   select * from sub_lote 
INNER JOIN lote on sub_lote.fk_id_lote = lote.id_lote 
WHERE lote.id_lote=_id_slote
ORDER BY sub_lote._slote_nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_variedades` (IN `_id_cultivo` INT)   select * from variedad
	INNER JOIN cultivo ON variedad.id_cultivo = cultivo.id_cultivo
    WHERE cultivo.id_cultivo=_id_cultivo
	order by variedad.nombre_variedad asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_variedad_lotes` (IN `_id_slote` INT)   SELECT fundo.s_lote,variedad.id_variedad,variedad.nombre_variedad FROM variedad
INNER JOIN fundo ON variedad.id_variedad= fundo.variedad
WHERE fundo.s_lote=_id_slote$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_reporte` (IN `_ideliminar` INT)   DELETE FROM reporte
	WHERE reporte.id_reporte=_ideliminar$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_emailnoexiste_registrado` (IN `_email` VARCHAR(50))   BEGIN
	SELECT * FROM usuarios
	WHERE email = _email;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_reportes` (IN `_inicial` DATETIME, IN `_final` DATETIME)   SELECT reporte.id_reporte, reporte.fecha_hora, reporte.turno,
       CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS jefe_fundo,
       reporte.nom_fundo, lote.nombre_lote, sub_lote._slote_nombre,
       cultivo.nombre_cultivo, variedad.nombre_variedad,
       reporte.aprob_jefefundo, reporte.aprob_jefesanidad
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo = usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote = lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote = sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo = cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad = variedad.id_variedad
WHERE reporte.fecha_hora >= CONCAT(_inicial)
  AND reporte.fecha_hora < DATE_SUB(CONCAT(_final), INTERVAL -1 DAY)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundos_getdata` (IN `_idfundo` INT)   SELECT fundo.id_fundo,fundo.jefe_fundo,fundo.nombre,usuarios.nombres,usuarios.apellidos,fundo.lote,fundo.s_lote,fundo.hectareas,cultivo.id_cultivo,variedad.id_variedad FROM fundo INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario INNER JOIN cultivo on fundo.cultivo= cultivo.id_cultivo INNER JOIN variedad ON fundo.variedad=variedad.id_variedad
	WHERE fundo.id_fundo = _idfundo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundos_listar` ()   BEGIN
    SELECT fundo.id_fundo,fundo.nombre,usuarios.nombres,usuarios.apellidos,lote.nombre_lote,sub_lote._slote_nombre,fundo.hectareas,cultivo.nombre_cultivo,variedad.nombre_variedad FROM fundo INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario INNER JOIN cultivo on fundo.cultivo= cultivo.id_cultivo INNER JOIN variedad ON fundo.variedad=variedad.id_variedad INNER JOIN lote ON fundo.lote= lote.id_lote INNER JOIN sub_lote ON fundo.s_lote=sub_lote.id_sub_lote ORDER BY fundo.nombre ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundoYaRegistrado` (IN `_nombrefundo` VARCHAR(20))   BEGIN
    SELECT * FROM fundo
    WHERE fundo.nombre = _nombrefundo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundo_filtrar_categorias` (IN `_idJefe` INT)   SELECT fundo.jefe_fundo,fundo.id_fundo,fundo.nombre,usuarios.nombres,usuarios.apellidos,lote.nombre_lote,sub_lote._slote_nombre,fundo.hectareas,cultivo.nombre_cultivo,variedad.nombre_variedad FROM fundo 
INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario 
INNER JOIN cultivo on fundo.cultivo= cultivo.id_cultivo 
INNER JOIN variedad ON fundo.variedad=variedad.id_variedad 
INNER JOIN lote ON fundo.lote= lote.id_lote 
INNER JOIN sub_lote ON fundo.s_lote=sub_lote.id_sub_lote 
WHERE fundo.jefe_fundo=_idJefe
ORDER BY fundo.nombre ASC$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_detalle` (IN `_id_reporte` INT)   SELECT motivo_aplicacion.nombre_motivo, productos_sanidad.nombre_producto, detalle_reporte.diascarencia, detalle_reporte.dosiscil, detalle_reporte.ncil, detalle_reporte.dosistanque, detalle_reporte.totalproducto, detalle_reporte.dosisHA, detalle_reporte.HAaplicada, detalle_reporte.gastoH20 FROM detalle_reporte INNER JOIN motivo_aplicacion ON detalle_reporte.motivo_aplicacion=motivo_aplicacion.id_motivo INNER JOIN productos_sanidad ON detalle_reporte.producto=productos_sanidad.id_producto WHERE detalle_reporte.fkreporte=_id_reporte$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_getdata` (IN `_idreporte` INT)   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,reporte.enc_sanidad,reporte.enc_QA,reporte.enc_almacen, CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,reporte.nom_fundo,lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_listar` ()   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,reporte.nom_fundo,lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
WHERE DATE(reporte.fecha_hora) = CURDATE()$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_modificar` (IN `_idreporte` INT, IN `_encsanidad` VARCHAR(50), IN `_encQA` VARCHAR(50), IN `_encAlmacen` VARCHAR(50), IN `_jefefundo` INT, IN `_nomfundo` VARCHAR(30), IN `_lote` INT, IN `_slote` INT, IN `_cultivo` INT, IN `_varriedad` INT)   UPDATE reporte SET
reporte.enc_sanidad=_encsanidad,
reporte.enc_QA=_encQA,
reporte.enc_almacen=_encAlmacen,
reporte.fk_jefe_fundo=_jefefundo,
reporte.nom_fundo=_nomfundo,
reporte.fk_lote=_lote,
reporte.fk_slote=_slote,
reporte.fk_cultivo=_cultivo,
reporte.fk_variedad=_varriedad
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_registro` (IN `_fecha_hora` DATETIME, IN `_turno` VARCHAR(15), IN `_enc_sanidad` VARCHAR(50), IN `_enc_QA` VARCHAR(50), IN `_enc_almacen` VARCHAR(50), IN `_fundo` INT, IN `_nonfundo` VARCHAR(30), IN `_lote` INT, IN `_slote` INT, IN `_cultivo` INT, IN `_variedad` INT)   INSERT INTO `reporte`( `fecha_hora`, `turno`, `enc_sanidad`, `enc_QA`, `enc_almacen`, `fk_jefe_fundo`, `nom_fundo`, `fk_lote`, `fk_slote`, `fk_cultivo`, `fk_variedad`, `aprob_jefefundo`, `aprob_jefesanidad`) VALUES (_fecha_hora,_turno,_enc_sanidad,_enc_QA,_enc_almacen,_fundo,_nonfundo,_lote,_slote,_cultivo,_variedad,'No Aprobado','No Aprobado')$$

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
(1, '2024-01-20');

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
-- Estructura de tabla para la tabla `detalle_reporte`
--

CREATE TABLE `detalle_reporte` (
  `id_detallereporte` int(11) NOT NULL,
  `motivo_aplicacion` int(11) NOT NULL,
  `producto` int(11) NOT NULL,
  `unidad` varchar(15) NOT NULL,
  `diascarencia` varchar(30) NOT NULL,
  `dosiscil` varchar(30) NOT NULL,
  `ncil` varchar(30) NOT NULL,
  `dosistanque` varchar(30) NOT NULL,
  `totalproducto` varchar(30) NOT NULL,
  `dosisHA` varchar(30) NOT NULL,
  `HAaplicada` varchar(30) NOT NULL,
  `gastoH20` varchar(30) NOT NULL,
  `fkreporte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_reporte`
--

INSERT INTO `detalle_reporte` (`id_detallereporte`, `motivo_aplicacion`, `producto`, `unidad`, `diascarencia`, `dosiscil`, `ncil`, `dosistanque`, `totalproducto`, `dosisHA`, `HAaplicada`, `gastoH20`, `fkreporte`) VALUES
(1, 10, 10, 'unn', 'aa', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 11),
(2, 24, 14, 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 10),
(3, 24, 14, 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fundo`
--

CREATE TABLE `fundo` (
  `id_fundo` int(11) NOT NULL,
  `jefe_fundo` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `lote` int(11) NOT NULL,
  `s_lote` int(11) NOT NULL,
  `hectareas` double(7,2) NOT NULL,
  `cultivo` int(11) NOT NULL,
  `variedad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fundo`
--

INSERT INTO `fundo` (`id_fundo`, `jefe_fundo`, `nombre`, `lote`, `s_lote`, `hectareas`, `cultivo`, `variedad`) VALUES
(622, 16, 'Santa Margarita', 1, 57, 17.00, 1, 1),
(623, 16, 'Santa Margarita', 2, 58, 21.00, 1, 1),
(624, 16, 'Santa Margarita', 3, 59, 21.03, 1, 1),
(625, 16, 'Santa Margarita', 4, 60, 7.87, 1, 1),
(626, 17, 'Santa Margarita', 5, 61, 8.80, 1, 1),
(627, 17, 'Santa Margarita', 6, 62, 18.64, 1, 1),
(628, 17, 'Santa Margarita', 7, 63, 17.41, 1, 1),
(629, 17, 'Santa Margarita', 8, 64, 11.65, 1, 1),
(630, 18, 'Santa Margarita', 9, 65, 25.78, 1, 1),
(631, 18, 'Santa Margarita', 10, 66, 26.72, 1, 1),
(632, 18, 'Santa Margarita', 11, 67, 5.06, 1, 1),
(633, 19, 'Santa Margarita', 12, 68, 9.30, 1, 1),
(634, 19, 'Santa Margarita', 13, 69, 21.03, 1, 1),
(635, 19, 'Santa Margarita', 14, 70, 17.67, 1, 1),
(636, 19, 'Santa Margarita', 15, 71, 15.73, 1, 1),
(637, 20, 'SAN HILARION', 16, 72, 6.36, 1, 2),
(638, 20, 'SAN HILARION', 17, 73, 8.76, 1, 2),
(639, 20, 'SAN HILARION', 18, 74, 8.65, 1, 2),
(640, 20, 'SAN HILARION', 19, 75, 4.05, 1, 2),
(641, 20, 'SAN HILARION', 20, 76, 8.54, 1, 2),
(642, 20, 'SAN HILARION', 21, 77, 3.33, 1, 2),
(643, 20, 'SAN HILARION', 22, 78, 7.57, 1, 2),
(644, 20, 'SAN HILARION', 23, 79, 3.63, 1, 2),
(645, 21, 'PROYECTO VID SANTA MARGARITA', 24, 80, 40.00, 1, 2),
(646, 21, 'PROYECTO VID SANTA MARGARITA', 25, 81, 25.00, 1, 4),
(647, 22, 'Santa Esperanza', 26, 82, 0.96, 1, 4),
(648, 22, 'Santa Esperanza', 27, 83, 1.02, 1, 5),
(649, 22, 'Santa Esperanza', 28, 84, 8.51, 1, 6),
(650, 22, 'Santa Esperanza', 29, 85, 1.02, 1, 2),
(651, 22, 'Santa Esperanza', 30, 86, 1.02, 1, 8),
(652, 22, 'Santa Esperanza', 31, 87, 23.24, 5, 16),
(653, 22, 'Santa Esperanza', 32, 88, 7.00, 5, 16),
(654, 22, 'Santa Esperanza', 33, 89, 3.20, 5, 16),
(655, 23, 'Santa Esperanza', 34, 90, 10.00, 5, 17),
(656, 23, 'Santa Esperanza', 35, 91, 66.19, 5, 16),
(657, 23, 'Santa Esperanza', 36, 92, 27.19, 5, 16),
(658, 24, 'SANTA LUCIA', 37, 93, 8.50, 4, 18),
(659, 24, 'SANTA LUCIA', 37, 94, 12.62, 4, 18),
(660, 24, 'SANTA LUCIA', 38, 95, 10.27, 4, 18),
(661, 24, 'SANTA LUCIA', 38, 96, 11.61, 4, 18),
(662, 24, 'SANTA LUCIA', 39, 97, 8.36, 4, 18),
(663, 24, 'SANTA LUCIA', 39, 98, 9.00, 4, 18),
(664, 25, 'DOS MARIAS', 40, 99, 44.00, 6, 19),
(665, 26, 'DOS MARIAS', 41, 100, 54.41, 6, 19),
(666, 27, 'DOS MARIAS', 42, 101, 55.45, 6, 19),
(667, 25, 'DOS MARIAS', 43, 102, 20.59, 6, 19),
(668, 25, 'DOS MARIAS', 43, 102, 0.80, 6, 20),
(669, 28, 'SANTA INES', 44, 104, 72.40, 6, 19),
(670, 28, 'SANTA INES', 44, 104, 0.20, 6, 20),
(671, 27, 'SANTA ISABEL', 45, 106, 12.00, 6, 19),
(672, 29, 'SAN ISIDRO LABRADOR', 46, 107, 20.50, 10, 21),
(673, 29, 'LUREN', 47, 108, 8.00, 10, 22),
(674, 29, 'FORTUNA', 48, 109, 47.00, 10, 21),
(675, 29, 'SANTA CARLA', 49, 110, 10.87, 10, 21),
(676, 29, 'GLORIA', 50, 111, 11.35, 10, 21),
(677, 29, 'GLORIA', 51, 112, 1.80, 10, 21),
(678, 24, 'SANTA LUCIA', 52, 113, 11.30, 10, 21),
(679, 29, 'ALPINE 511', 53, 114, 26.50, 10, 21),
(680, 29, 'ALPINE 511', 54, 115, 41.50, 10, 23),
(681, 29, 'ALPINE PERU', 55, 116, 33.00, 10, 24),
(682, 29, 'ALPINE PERU', 56, 117, 14.00, 10, 25);

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
(506, 4, '<p>av</p>', '<p>a</p>', '<p>a</p>', '<p>a</p>', '2024-02-10'),
(507, 1, '<p>b</p>', '<p>b</p>', '<p>b</p>', '<p>b</p>', '2024-02-01'),
(508, 2, '<p>c</p>', '<p>c</p>', '<p>c</p>', '<p>c</p>', '2024-11-23'),
(509, 1, '<p>e</p>', '<p>e</p>', '<p>e</p>', '<p>e</p>', '2025-10-24');

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
-- Estructura de tabla para la tabla `reporte`
--

CREATE TABLE `reporte` (
  `id_reporte` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `turno` varchar(15) NOT NULL,
  `enc_sanidad` varchar(50) NOT NULL,
  `enc_QA` varchar(50) NOT NULL,
  `enc_almacen` varchar(50) NOT NULL,
  `fk_jefe_fundo` int(11) NOT NULL,
  `nom_fundo` varchar(30) NOT NULL,
  `fk_lote` int(11) NOT NULL,
  `fk_slote` int(11) NOT NULL,
  `fk_cultivo` int(11) NOT NULL,
  `fk_variedad` int(11) NOT NULL,
  `aprob_jefefundo` varchar(15) NOT NULL,
  `aprob_jefesanidad` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reporte`
--

INSERT INTO `reporte` (`id_reporte`, `fecha_hora`, `turno`, `enc_sanidad`, `enc_QA`, `enc_almacen`, `fk_jefe_fundo`, `nom_fundo`, `fk_lote`, `fk_slote`, `fk_cultivo`, `fk_variedad`, `aprob_jefefundo`, `aprob_jefesanidad`) VALUES
(10, '2024-01-22 07:51:35', 'Mañana', 'c', 'c', 'c', 29, 'ALPINE 511', 53, 114, 10, 21, 'No Aprobado', 'No Aprobado'),
(11, '2024-01-20 15:33:53', 'Noche', 'e', 'e', 'e', 17, 'e', 24, 64, 10, 6, '', ''),
(12, '2024-01-22 22:44:30', 'Noche', 'bb', 'bbb', 'bbb', 24, 'SANTA LUCIA', 38, 96, 4, 18, 'No Aprobado', 'No Aprobado');

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
(13, 'Administrador', 'Administrador', 'Administrador', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-10', NULL, 'A', 'A', 'admin@admin.com', NULL, 9),
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
(32, 'Operario', 'Operario', 'Operario', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-17', NULL, 'O', 'A', 'uva1s@beta.com', NULL, 3),
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
-- Indices de la tabla `detalle_reporte`
--
ALTER TABLE `detalle_reporte`
  ADD PRIMARY KEY (`id_detallereporte`),
  ADD KEY `fkreporte` (`fkreporte`),
  ADD KEY `motivo_aplicacion` (`motivo_aplicacion`,`producto`),
  ADD KEY `producto` (`producto`);

--
-- Indices de la tabla `fundo`
--
ALTER TABLE `fundo`
  ADD PRIMARY KEY (`id_fundo`),
  ADD KEY `jefe_fundo` (`jefe_fundo`),
  ADD KEY `cultivo` (`cultivo`),
  ADD KEY `variedad` (`variedad`),
  ADD KEY `lote` (`lote`,`s_lote`),
  ADD KEY `s_lote` (`s_lote`);

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
-- Indices de la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD PRIMARY KEY (`id_reporte`),
  ADD KEY `fk_jefe_fundo` (`fk_jefe_fundo`,`fk_lote`,`fk_slote`,`fk_cultivo`,`fk_variedad`),
  ADD KEY `fk_cultivo` (`fk_cultivo`),
  ADD KEY `fk_variedad` (`fk_variedad`),
  ADD KEY `fk_lote` (`fk_lote`),
  ADD KEY `fk_slote` (`fk_slote`);

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
-- AUTO_INCREMENT de la tabla `detalle_reporte`
--
ALTER TABLE `detalle_reporte`
  MODIFY `id_detallereporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `fundo`
--
ALTER TABLE `fundo`
  MODIFY `id_fundo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=684;

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
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=510;

--
-- AUTO_INCREMENT de la tabla `productos_sanidad`
--
ALTER TABLE `productos_sanidad`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT de la tabla `reporte`
--
ALTER TABLE `reporte`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
-- Filtros para la tabla `detalle_reporte`
--
ALTER TABLE `detalle_reporte`
  ADD CONSTRAINT `detalle_reporte_ibfk_1` FOREIGN KEY (`fkreporte`) REFERENCES `reporte` (`id_reporte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_reporte_ibfk_2` FOREIGN KEY (`motivo_aplicacion`) REFERENCES `motivo_aplicacion` (`id_motivo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_reporte_ibfk_3` FOREIGN KEY (`producto`) REFERENCES `productos_sanidad` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `fundo`
--
ALTER TABLE `fundo`
  ADD CONSTRAINT `fundo_ibfk_1` FOREIGN KEY (`jefe_fundo`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fundo_ibfk_2` FOREIGN KEY (`cultivo`) REFERENCES `cultivo` (`id_cultivo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fundo_ibfk_3` FOREIGN KEY (`variedad`) REFERENCES `variedad` (`id_variedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fundo_ibfk_4` FOREIGN KEY (`s_lote`) REFERENCES `sub_lote` (`id_sub_lote`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fundo_ibfk_5` FOREIGN KEY (`lote`) REFERENCES `lote` (`id_lote`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_idcategoria_prod` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`idcategoria`);

--
-- Filtros para la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`fk_cultivo`) REFERENCES `cultivo` (`id_cultivo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_2` FOREIGN KEY (`fk_variedad`) REFERENCES `variedad` (`id_variedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_3` FOREIGN KEY (`fk_lote`) REFERENCES `lote` (`id_lote`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_4` FOREIGN KEY (`fk_jefe_fundo`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `reporte_ibfk_5` FOREIGN KEY (`fk_slote`) REFERENCES `sub_lote` (`id_sub_lote`);

--
-- Filtros para la tabla `sub_lote`
--
ALTER TABLE `sub_lote`
  ADD CONSTRAINT `sub_lote_ibfk_1` FOREIGN KEY (`fk_id_lote`) REFERENCES `lote` (`id_lote`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `variedad`
--
ALTER TABLE `variedad`
  ADD CONSTRAINT `variedad_ibfk_1` FOREIGN KEY (`id_cultivo`) REFERENCES `cultivo` (`id_cultivo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
