-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-02-2024 a las 16:11:21
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_aprobar_reporteCalidad` (IN `_idReporte` INT)   UPDATE reporte SET reporte.aprob_jefeCalidad='Aprobado'
WHERE reporte.id_reporte=_idReporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_aprobar_reporteJFundo` (IN `_idreporte` INT)   UPDATE reporte SET
reporte.aprob_jefefundo='Aprobado'
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_aprobar_reporteSanidad` (IN `_idreporte` INT, IN `_idjefe_sanidad` INT)   UPDATE reporte SET
reporte.aprob_jefesanidad='Aprobado',
reporte.fk_jefeSanidad=_idjefe_sanidad
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_asignar_fecha_llegada` (IN `_idreporte` INT, IN `_fecha_llegada` DATE)   UPDATE reporte SET reporte.fecha_llegada=_fecha_llegada
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_asignar_JOperaciones` (IN `_idjefefundo` INT, IN `_idjefeoperaciones` INT)   UPDATE `usuarios` SET `fk_jOperaciones`=_idjefeoperaciones 
WHERE usuarios.idusuario=_idjefefundo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cambiarEstadoReporte` (IN `_idreporte` INT)   UPDATE `reporte` SET `aprob_jefefundo`='No Aprobado',`aprob_jefesanidad`='No Aprobado' 
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargarCategoriaEtaCultivoBitacora` ()   SELECT * FROM etapa_cultivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargarCategoriaPEPBitacora` ()   SELECT * FROM pep$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_categoria_cultivo` ()   BEGIN
	SELECT * FROM cultivo ORDER BY cultivo.nombre_cultivo ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_categoria_lote` (IN `_fundo` INT)   SELECT * FROM lote
WHERE lote.fk_fundo=_fundo
ORDER BY lote.nombre_lote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_cultivoGET` (IN `_idslote` INT)   SELECT fundo.cultivo,fundo.s_lote,cultivo.nombre_cultivo from fundo INNER JOIN cultivo on fundo.cultivo=cultivo.id_cultivo WHERE fundo.s_lote=_idslote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_cultivos_lotes` (IN `_id_slote` INT)   SELECT sub_lote.id_sub_lote,sub_lote._slote_nombre,cultivo.id_cultivo, cultivo.nombre_cultivo from fundo INNER JOIN sub_lote ON fundo.s_lote=sub_lote.id_sub_lote INNER JOIN cultivo ON fundo.cultivo=cultivo.id_cultivo WHERE sub_lote.id_sub_lote=_id_slote
GROUP BY cultivo.nombre_cultivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_fundos_fundos` ()   SELECT nombres_fundo.id_fundo_nombre,nombres_fundo.nombre_fundo from nombres_fundo
GROUP BY nombres_fundo.nombre_fundo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_jefe_fundo` ()   SELECT usuarios.idusuario, CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS Nombre
    FROM usuarios
    WHERE usuarios.nivelacceso = 'J'
    and usuarios.estado='A'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_JOperaciones` ()   SELECT usuarios.idusuario,usuarios.nombres,usuarios.apellidos from usuarios 
WHERE usuarios.nivelacceso='T' AND usuarios.estado='A'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_lotes_SJefefundo` ()   SELECT * FROM  lote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_lote_nombreFundo` (IN `_nombreFundo` VARCHAR(30), IN `_idjefe` INT)   SELECT fundo.nombre, lote.id_lote,lote.nombre_lote from fundo
INNER JOIN lote ON 
fundo.lote= lote.id_lote
WHERE fundo.nombre=_nombreFundo and fundo.jefe_fundo=_idjefe
GROUP BY lote.id_lote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_motivo_aplicacion` ()   SELECT * FROM motivo_aplicacion
WHERE motivo_aplicacion.estado='A'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_nombre_fundos` (IN `_idjefe` INT)   SELECT * FROM fundo 
INNER JOIN nombres_fundo ON fundo.nombre=nombres_fundo.id_fundo_nombre
WHERE fundo.jefe_fundo=_idjefe
GROUP BY fundo.nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_productos_sanidad` ()   SELECT * FROM productos_sanidad
WHERE productos_sanidad.estado='A'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_slotes_SLote` ()   SELECT * FROM sub_lote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_s_lotes` (IN `_id_slote` INT)   select * from sub_lote 
INNER JOIN lote on sub_lote.fk_id_lote = lote.id_lote 
WHERE lote.id_lote=_id_slote
ORDER BY sub_lote._slote_nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_variedades` (IN `_id_cultivo` INT)   select * from variedad
	INNER JOIN cultivo ON variedad.id_cultivo = cultivo.id_cultivo
    WHERE cultivo.id_cultivo=_id_cultivo
	order by variedad.nombre_variedad asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_variedadesBitacora` ()   SELECT * from variedad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_cargar_variedad_lotes` (IN `_id_slote` INT)   SELECT fundo.s_lote,variedad.id_variedad,variedad.nombre_variedad FROM variedad
INNER JOIN fundo ON variedad.id_variedad= fundo.variedad
WHERE fundo.s_lote=_id_slote$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_categorias_almacen_cargar` ()   BEGIN
	SELECT * FROM categoria_productos_almacen ORDER BY id_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_categorias_cargar` ()   BEGIN
	SELECT * FROM categorias ORDER BY idcategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_desasignar_JOperaciones` (IN `_idjefefundo` INT)   UPDATE `usuarios` SET `fk_jOperaciones`=null 
WHERE usuarios.idusuario=_idjefefundo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_detalle_getunidad` (IN `_idproducto` INT)   SELECT * FROM productos_sanidad 
WHERE productos_sanidad.id_producto=_idproducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_detalle_registro` (IN `_motivo_aplicacion` INT, IN `_producto` INT, IN `_unidad` TEXT, IN `_dcarencia` INT, IN `_dosiscil` TEXT, IN `_ncil` TEXT, IN `_dosistanque` TEXT, IN `_totalproducto` TEXT, IN `_dosisHA` TEXT, IN `_HAaplicada` TEXT, IN `_gastoH2O` TEXT, IN `_fkreporte` INT)   INSERT INTO `detalle_reporte`(`motivo_aplicacion`, `producto`, `unidad`, `diascarencia`, `dosiscil`, `ncil`, `dosistanque`, `totalproducto`, `dosisHA`, `HAaplicada`, `gastoH2O`, `fkreporte`) VALUES (_motivo_aplicacion,_producto,_unidad,_dcarencia,_dosiscil,_ncil,_dosistanque,_totalproducto,_dosisHA,_HAaplicada,_gastoH2O,_fkreporte)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_detalle` (IN `_iddetalle` INT)   DELETE FROM detalle_reporte
	WHERE detalle_reporte.id_detallereporte=_iddetalle$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Spu_eliminar_detalle_seguimiento` (IN `_id_eliminar` INT, IN `_observacion` TEXT, IN `_nombre` TEXT)   INSERT INTO `registro_actividad_detalle`(`RDFecha`, `RDnombres`, `RDcodigo_reporte`, `RDaccion`, `RDobservacion`) 
VALUES 
    (NOW(), _nombre, _id_eliminar, 'Eliminar', _observacion)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_motivo_sanidad` (IN `_idmotivo` INT)   BEGIN
	UPDATE motivo_aplicacion SET
		motivo_aplicacion.estado = "I"
	WHERE motivo_aplicacion.id_motivo = _idmotivo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_producto_sanidad` (IN `_idProducto` INT)   BEGIN
	UPDATE productos_sanidad SET
		productos_sanidad.estado = "I"
	WHERE productos_sanidad.id_producto = _idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_eliminar_reporte` (IN `_ideliminar` INT)   DELETE FROM reporte
WHERE reporte.id_reporte = _ideliminar$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Spu_eliminar_reporte_seguimiento` (IN `_ideliminar` INT, IN `_observacion` TEXT, IN `_nombre` TEXT, IN `_eliminar` TEXT)   INSERT INTO registro_actividad_reporte 
    (`ARfecha`, `ARnombres`, `ARcodigo_reporte`, `ARaccion`, `ARobservacion`,registro_actividad_reporte.eliminar) 
VALUES 
    (NOW(), _nombre, _ideliminar, 'Eliminar', _observacion,_eliminar)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_emailnoexiste_registrado` (IN `_email` VARCHAR(50))   BEGIN
	SELECT * FROM usuarios
	WHERE email = _email;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_LlegadaProductos` (IN `_inicial` DATE, IN `_final` DATE)   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,nombres_fundo.nombre_fundo,
lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad, 
reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo,reporte.fecha_llegada
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
WHERE reporte.aprob_jefefundo='Aprobado'
AND reporte.aprob_jefesanidad='Aprobado'
AND reporte.aprob_jefeCalidad='Aprobado'
AND reporte.fecha_hora >=  CONCAT(_inicial, ' 00:00:00')
AND reporte.fecha_hora < CONCAT(_final, ' 23:59:59')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_producto_accion` (IN `_inicial` DATE, IN `_final` DATE)   SELECT * FROM registro_actividad_detalle
WHERE registro_actividad_detalle.RDfecha >= CONCAT(_inicial, ' 00:00:00')
  AND registro_actividad_detalle.RDfecha < CONCAT(_final, ' 23:59:59')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_reportes` (IN `_inicial` DATE, IN `_final` DATE)   SELECT reporte.id_reporte, reporte.fecha_hora, reporte.turno,
CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS jefe_fundo,
nombres_fundo.nombre_fundo, lote.nombre_lote, sub_lote._slote_nombre,
cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo, 
reporte.aprob_jefesanidad,reporte.aprob_jefeCalidad,reporte.nrReserva,
reporte.nrInstructivo,pep.nombre_pep,etapa_cultivo.nombreEcultivo
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo = usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote = lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote = sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo = cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad = variedad.id_variedad
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
WHERE reporte.fecha_hora >=  CONCAT(_inicial, ' 00:00:00')
  AND reporte.fecha_hora < CONCAT(_final, ' 23:59:59')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_reportes_accion` (IN `_inicial` DATE, IN `_final` DATE)   SELECT * FROM registro_actividad_reporte
WHERE registro_actividad_reporte.ARfecha >= CONCAT(_inicial, ' 00:00:00')
  AND registro_actividad_reporte.ARfecha < CONCAT(_final, ' 23:59:59')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_reportes_administrador` (IN `_inicial` DATE, IN `_final` DATE)   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,nombres_fundo.nombre_fundo,lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad, motivo_aplicacion.nombre_motivo,productos_sanidad.nombre_producto,detalle_reporte.diascarencia, detalle_reporte.dosiscil, reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo,detalle_reporte.ncil,detalle_reporte.dosistanque,detalle_reporte.totalproducto, detalle_reporte.dosisHA,detalle_reporte.HAaplicada,detalle_reporte.gastoH2O FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN detalle_reporte ON reporte.id_reporte=detalle_reporte.fkreporte
INNER JOIN motivo_aplicacion ON detalle_reporte.motivo_aplicacion=motivo_aplicacion.id_motivo
INNER JOIN productos_sanidad ON detalle_reporte.producto= productos_sanidad.id_producto
WHERE reporte.fecha_hora >= CONCAT(_inicial, ' 00:00:00')
  AND reporte.fecha_hora < CONCAT(_final, ' 23:59:59')
  AND reporte.aprob_jefeCalidad='Aprobado'
ORDER BY reporte.fecha_hora$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_reportes_calidad` (IN `_inicial` DATE, IN `_final` DATE)   SELECT reporte.id_reporte, reporte.fecha_hora, reporte.turno,
CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS jefe_fundo,
nombres_fundo.nombre_fundo, lote.nombre_lote, sub_lote._slote_nombre,
cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo, 
reporte.aprob_jefesanidad,reporte.aprob_jefeCalidad,reporte.nrReserva,
reporte.nrInstructivo,pep.nombre_pep,etapa_cultivo.nombreEcultivo
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo = usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote = lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote = sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo = cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad = variedad.id_variedad
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
WHERE reporte.fecha_hora >=  CONCAT(_inicial, ' 00:00:00')
AND reporte.fecha_hora < CONCAT(_final, ' 23:59:59')
AND reporte.aprob_jefefundo='Aprobado'
AND reporte.aprob_jefesanidad='Aprobado'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_reportes_jfundo` (IN `_inicial` DATE, IN `_final` DATE, IN `_jefefundo` INT)   SELECT reporte.id_reporte, reporte.fecha_hora, reporte.turno,
       CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS jefe_fundo,
       nombres_fundo.nombre_fundo, lote.nombre_lote, sub_lote._slote_nombre,
       cultivo.nombre_cultivo, variedad.nombre_variedad,
       reporte.aprob_jefefundo, reporte.aprob_jefesanidad,reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo = usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote = lote.id_lote
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN sub_lote ON reporte.fk_slote = sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo = cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad = variedad.id_variedad
WHERE reporte.fecha_hora >= CONCAT(_inicial, ' 00:00:00')
  AND reporte.fecha_hora < CONCAT(_final, ' 23:59:59')
  AND usuarios.idusuario=_jefefundo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_reportes_jfundoAdministrador` (IN `_inicial` DATE, IN `_final` DATE)   SELECT reporte.id_reporte, reporte.fecha_hora, reporte.turno,
       CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS jefe_fundo,
       nombres_fundo.nombre_fundo, lote.nombre_lote, sub_lote._slote_nombre,
       cultivo.nombre_cultivo, variedad.nombre_variedad,
       reporte.aprob_jefefundo, reporte.aprob_jefesanidad,reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo = usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote = lote.id_lote
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN sub_lote ON reporte.fk_slote = sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo = cultivo.id_cultivo
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
INNER JOIN variedad ON reporte.fk_variedad = variedad.id_variedad
WHERE reporte.fecha_hora >= CONCAT(_inicial, ' 00:00:00')
  AND reporte.fecha_hora <  CONCAT(_final, ' 23:59:59')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_filtrar_fecha_reportes_joperaciones` (IN `_inicial` DATE, IN `_final` DATE, IN `_idjoperaciones` INT)   SELECT reporte.id_reporte, reporte.fecha_hora, reporte.turno,
       CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS jefe_fundo,
       nombres_fundo.nombre_fundo, lote.nombre_lote, sub_lote._slote_nombre,
       cultivo.nombre_cultivo, variedad.nombre_variedad,
       reporte.aprob_jefefundo, reporte.aprob_jefesanidad,reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo = usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote = lote.id_lote
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN sub_lote ON reporte.fk_slote = sub_lote.id_sub_lote
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
INNER JOIN cultivo ON reporte.fk_cultivo = cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad = variedad.id_variedad
WHERE reporte.fecha_hora >= CONCAT(_inicial, ' 00:00:00')
  AND reporte.fecha_hora < CONCAT(_final, ' 23:59:59')
  AND usuarios.fk_jOperaciones=_idjoperaciones$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundos_getdata` (IN `_idfundo` INT)   SELECT fundo.id_fundo,fundo.jefe_fundo,fundo.nombre,
usuarios.nombres,usuarios.apellidos,fundo.lote,fundo.s_lote,
fundo.hectareas,fundo.cultivo,fundo.variedad
FROM fundo 
INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario 
WHERE fundo.id_fundo = _idfundo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundos_listar` ()   BEGIN
    SELECT fundo.id_fundo,fundo.nombre,usuarios.nombres,nombres_fundo.nombre_fundo,usuarios.apellidos,lote.nombre_lote,sub_lote._slote_nombre,fundo.hectareas,cultivo.nombre_cultivo,variedad.nombre_variedad FROM fundo 
    INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario 
    INNER JOIN cultivo on fundo.cultivo= cultivo.id_cultivo 
    INNER JOIN variedad ON fundo.variedad=variedad.id_variedad 
    INNER JOIN lote ON fundo.lote= lote.id_lote 
    INNER JOIN sub_lote ON fundo.s_lote=sub_lote.id_sub_lote 
    INNER JOIN nombres_fundo ON fundo.nombre=nombres_fundo.id_fundo_nombre
    ORDER BY fundo.nombre ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundoYaRegistrado` (IN `_nombrefundo` VARCHAR(20))   BEGIN
    SELECT * FROM fundo
    WHERE fundo.nombre = _nombrefundo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_fundo_filtrar_categorias` (IN `_idJefe` INT)   SELECT fundo.jefe_fundo,fundo.id_fundo,fundo.nombre,nombres_fundo.nombre_fundo,usuarios.nombres,usuarios.apellidos,lote.nombre_lote,sub_lote._slote_nombre,fundo.hectareas,cultivo.nombre_cultivo,variedad.nombre_variedad FROM fundo 
INNER join usuarios on fundo.jefe_fundo=usuarios.idusuario 
INNER JOIN cultivo on fundo.cultivo= cultivo.id_cultivo 
INNER JOIN variedad ON fundo.variedad=variedad.id_variedad 
INNER JOIN lote ON fundo.lote= lote.id_lote 
INNER JOIN sub_lote ON fundo.s_lote=sub_lote.id_sub_lote 
INNER JOIN nombres_fundo ON fundo.nombre=nombres_fundo.id_fundo_nombre
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_JOperaciones_getdata` (IN `_idJOperciones` INT)   SELECT * FROM usuarios 
WHERE usuarios.idusuario=_idJOperciones$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listarfiltro_JFundo_JOperaciones` (IN `_idJefeOperacciones` INT)   SELECT usuarios.idusuario,usuarios.nombres,usuarios.apellidos,
usuarios.fk_jOperaciones 
FROM `usuarios` 
WHERE  usuarios.nivelacceso='J'
AND usuarios.estado='A'
ORDER BY usuarios.idusuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_datos_reporte` (IN `_idReporte` INT)   SELECT CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo ,nombres_fundo.nombre_fundo,
lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo,variedad.nombre_variedad FROM reporte
INNER JOIN usuarios on reporte.fk_jefe_fundo=usuarios.idusuario
INNER JOIN lote ON lote.id_lote=reporte.fk_lote
INNER JOIN sub_lote ON sub_lote.id_sub_lote=reporte.fk_slote
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN cultivo ON cultivo.id_cultivo=reporte.fk_cultivo
INNER JOIN variedad ON variedad.id_variedad=reporte.fk_variedad
WHERE reporte.id_reporte=_idReporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_detalle` (IN `_id_reporte` INT)   SELECT motivo_aplicacion.nombre_motivo, productos_sanidad.nombre_producto,productos_sanidad.unidad,  detalle_reporte.diascarencia, detalle_reporte.dosiscil, detalle_reporte.ncil, detalle_reporte.dosistanque, detalle_reporte.totalproducto, detalle_reporte.dosisHA, detalle_reporte.HAaplicada, detalle_reporte.gastoH2O,detalle_reporte.id_detallereporte FROM detalle_reporte INNER JOIN motivo_aplicacion ON detalle_reporte.motivo_aplicacion=motivo_aplicacion.id_motivo INNER JOIN productos_sanidad ON detalle_reporte.producto=productos_sanidad.id_producto WHERE detalle_reporte.fkreporte=_id_reporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_JFundo_JOperaciones` ()   SELECT usuarios.idusuario,usuarios.nombres,usuarios.apellidos,
usuarios.fk_jOperaciones 
FROM `usuarios` 
WHERE  usuarios.nivelacceso='J'
AND usuarios.estado='A'
ORDER BY usuarios.idusuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_producto_acciones` ()   SELECT * FROM registro_actividad_detalle
WHERE DATE(registro_actividad_detalle.RDFecha) = CURDATE()
ORDER BY registro_actividad_detalle.id_RDreporte DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_reportes_porJefeFundo` (IN `_jefe` INT)   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,
CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,
nombres_fundo.nombre_fundo,lote.nombre_lote,sub_lote._slote_nombre,
cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,
reporte.aprob_jefesanidad,reporte.aprob_jefeCalidad,reporte.nrReserva,
reporte.nrInstructivo,pep.nombre_pep,etapa_cultivo.nombreEcultivo 
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
WHERE DATE(reporte.fecha_hora) = CURDATE() AND reporte.fk_jefe_fundo=_jefe$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_reportes_porJefeOperaciones` (IN `id_jefeOperaciones` INT)   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,
CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,
nombres_fundo.nombre_fundo,lote.nombre_lote,sub_lote._slote_nombre,
cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,
reporte.aprob_jefesanidad,reporte.aprob_jefeCalidad,reporte.nrReserva,
reporte.nrInstructivo,pep.nombre_pep,etapa_cultivo.nombreEcultivo
FROM reporte 
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario 
INNER JOIN lote ON reporte.fk_lote=lote.id_lote 
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote 
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo 
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad 
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo 
WHERE DATE(reporte.fecha_hora) = CURDATE() 
AND usuarios.fk_jOperaciones=id_jefeOperaciones$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_reporte_acciones` ()   SELECT * FROM registro_actividad_reporte
WHERE DATE(registro_actividad_reporte.ARfecha) = CURDATE()
ORDER BY registro_actividad_reporte.id_ARreporte DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Spu_modificar_reporte_seguimiento` (IN `_idmodificar` INT, IN `_observacion` TEXT, IN `_nombre` TEXT, IN `_antes` TEXT, IN `_despues` TEXT)   INSERT INTO registro_actividad_reporte 
    (`ARfecha`, `ARnombres`, `ARcodigo_reporte`, `ARaccion`, `ARobservacion`,registro_actividad_reporte.antes,registro_actividad_reporte.despues) 
VALUES 
    (NOW(), _nombre, _idmodificar, 'Modificar', _observacion,_antes,_despues)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_motivoAplicacion_getdata` (IN `_idmotivo` INT)   SELECT * from motivo_aplicacion
	WHERE motivo_aplicacion.id_motivo=_idmotivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_motivo_aplicacion_listar` ()   SELECT * from motivo_aplicacion 
ORDER BY motivo_aplicacion.nombre_motivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_motivo_aplicacion_modificar` (IN `_idmotivo` INT, IN `_nombremotivo` VARCHAR(30))   UPDATE motivo_aplicacion SET
	motivo_aplicacion.nombre_motivo= _nombremotivo
WHERE motivo_aplicacion.id_motivo=_idmotivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_motivo_aplicacion_registro` (IN `_nombre` VARCHAR(30))   INSERT INTO motivo_aplicacion(motivo_aplicacion.nombre_motivo) VALUES
(_nombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_nombreproducto_sanidad_registrado` (IN `_nombreproducto` VARCHAR(30))   SELECT * FROM productos_sanidad
WHERE productos_sanidad.nombre_producto=_nombreproducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_nombreusuario_registrado` (IN `_nombreusuario` VARCHAR(25))   BEGIN
	SELECT * FROM usuarios 
	WHERE nombreusuario = _nombreusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_nombre_motivo_aplicacion_registrado` (IN `_nombremotivo` VARCHAR(30))   SELECT * FROM motivo_aplicacion
WHERE motivo_aplicacion.nombre_motivo=_nombremotivo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productosSanidad_getdata` (IN `id_producto` INT)   SELECT * from productos_sanidad
	WHERE productos_sanidad.id_producto=id_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_sanidad_listar` ()   SELECT * FROM productos_sanidad ORDER BY productos_sanidad.nombre_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_sanidad_modificar` (IN `_idproducto` INT, IN `_codigoproducto` INT, IN `_nombreproducto` VARCHAR(30), IN `_unidad` VARCHAR(10))   UPDATE productos_sanidad SET
productos_sanidad.codigo_producto=_codigoproducto,
productos_sanidad.nombre_producto=_nombreproducto,
productos_sanidad.unidad=_unidad
WHERE productos_sanidad.id_producto=_idproducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_productos_sanidad_registro` (IN `_codigo` INT(11), IN `_nombre` VARCHAR(30), IN `_unidad` VARCHAR(20))   INSERT INTO productos_sanidad(productos_sanidad.codigo_producto,productos_sanidad.nombre_producto,productos_sanidad.unidad,productos_sanidad.estado) 		VALUES (_codigo,_nombre,_unidad,'A')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reactivar_motivo_sanidad` (IN `_idmotivo` INT)   BEGIN
	UPDATE motivo_aplicacion SET
		motivo_aplicacion.estado = "A"
	WHERE motivo_aplicacion.id_motivo = _idmotivo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reactivar_producto_sanidad` (IN `_idproducto` INT)   BEGIN
	UPDATE productos_sanidad SET
		estado = "A"
	WHERE productos_sanidad.id_producto = _idproducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_administrador_listar` ()   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,nombres_fundo.nombre_fundo,lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad, motivo_aplicacion.nombre_motivo,productos_sanidad.nombre_producto,detalle_reporte.diascarencia, detalle_reporte.dosiscil, detalle_reporte.ncil,detalle_reporte.dosistanque,detalle_reporte.totalproducto, 
reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo,detalle_reporte.dosisHA,detalle_reporte.HAaplicada,detalle_reporte.gastoH2O FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
INNER JOIN detalle_reporte ON reporte.id_reporte=detalle_reporte.fkreporte
INNER JOIN motivo_aplicacion ON detalle_reporte.motivo_aplicacion=motivo_aplicacion.id_motivo
INNER JOIN productos_sanidad ON detalle_reporte.producto= productos_sanidad.id_producto
WHERE DATE(reporte.fecha_hora) = CURDATE()
AND reporte.aprob_jefeCalidad='Aprobado'
ORDER BY reporte.fecha_hora$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_getdata` (IN `_idreporte` INT)   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,
reporte.enc_sanidad,reporte.enc_QA,reporte.enc_almacen,
reporte.fk_jefe_fundo,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS nombresJF,
reporte.nom_fundo,nombres_fundo.nombre_fundo,reporte.fk_lote,lote.nombre_lote,
reporte.fk_slote,sub_lote._slote_nombre,reporte.fk_cultivo,
cultivo.nombre_cultivo,reporte.fk_variedad,variedad.nombre_variedad,
reporte.aprob_jefefundo,reporte.aprob_jefesanidad,reporte.pep,pep.nombre_pep,
reporte.nrReserva,reporte.nrInstructivo,reporte.etapa_cultivo,etapa_cultivo.nombreEcultivo
FROM reporte
INNER JOIN usuarios ON usuarios.idusuario=reporte.fk_jefe_fundo
INNER JOIN nombres_fundo on nombres_fundo.id_fundo_nombre=reporte.nom_fundo
INNER JOIN lote ON lote.id_lote= reporte.fk_lote
INNER JOIN sub_lote on sub_lote.id_sub_lote= reporte.fk_slote
INNER JOIN cultivo ON cultivo.id_cultivo=reporte.fk_cultivo
INNER JOIN variedad ON variedad.id_variedad= reporte.fk_variedad
INNER JOIN pep on pep.id_pep= reporte.pep
INNER JOIN etapa_cultivo on etapa_cultivo.idEcultivo=reporte.etapa_cultivo
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_listar` ()   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,nombres_fundo.nombre_fundo,
lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad, 
reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
WHERE DATE(reporte.fecha_hora) = CURDATE()$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_listar_calidad` ()   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,nombres_fundo.nombre_fundo,
lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad, 
reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
WHERE DATE(reporte.fecha_hora) = CURDATE() 
AND reporte.aprob_jefefundo='Aprobado'
AND reporte.aprob_jefesanidad='Aprobado'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_listar_llegadaProductos` ()   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,nombres_fundo.nombre_fundo,
lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad, 
reporte.aprob_jefeCalidad,reporte.nrReserva,reporte.nrInstructivo,pep.nombre_pep,
etapa_cultivo.nombreEcultivo,reporte.fecha_llegada
FROM reporte
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario
INNER JOIN lote ON reporte.fk_lote=lote.id_lote
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN pep ON reporte.pep=pep.id_pep
inner JOIN etapa_cultivo ON reporte.etapa_cultivo=etapa_cultivo.idEcultivo
WHERE DATE(reporte.fecha_hora) = CURDATE()
AND reporte.aprob_jefefundo='Aprobado'
AND reporte.aprob_jefesanidad='Aprobado'
AND reporte.aprob_jefeCalidad='Aprobado'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_modificar` (IN `_idreporte` INT, IN `_encsanidad` VARCHAR(50), IN `_encQA` VARCHAR(50), IN `_encAlmacen` VARCHAR(50), IN `_jefefundo` INT, IN `_nomfundo` INT(30), IN `_lote` INT, IN `_slote` INT, IN `_cultivo` INT, IN `_varriedad` INT, IN `_nreserva` INT, IN `_ninstructivo` INT, IN `_pep` INT, IN `_etcultivo` INT)   UPDATE reporte SET
reporte.enc_sanidad=_encsanidad,
reporte.enc_QA=_encQA,
reporte.enc_almacen=_encAlmacen,
reporte.fk_jefe_fundo=_jefefundo,
reporte.nom_fundo=_nomfundo,
reporte.fk_lote=_lote,
reporte.fk_slote=_slote,
reporte.fk_cultivo=_cultivo,
reporte.fk_variedad=_varriedad,
reporte.aprob_jefefundo='No Aprobado',
reporte.aprob_jefesanidad='No Aprobado',
reporte.nrReserva=_nreserva,
reporte.nrInstructivo=_ninstructivo,
reporte.pep=_pep,
reporte.etapa_cultivo=_etcultivo
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_pdf` (IN `_idreporte` INT)   SELECT reporte.id_reporte, reporte.fecha_hora,reporte.turno,CONCAT(usuarios.nombres,' ',usuarios.apellidos) AS jefe_fundo,usuarios.sello,nombres_fundo.nombre_fundo,reporte.enc_sanidad, reporte.enc_QA,reporte.enc_almacen, lote.nombre_lote,sub_lote._slote_nombre, cultivo.nombre_cultivo, variedad.nombre_variedad,reporte.aprob_jefefundo,reporte.aprob_jefesanidad,reporte.aprob_jefeCalidad
FROM reporte 
INNER JOIN usuarios ON reporte.fk_jefe_fundo= usuarios.idusuario 
INNER JOIN lote ON reporte.fk_lote=lote.id_lote 
INNER JOIN sub_lote ON reporte.fk_slote= sub_lote.id_sub_lote 
INNER JOIN cultivo ON reporte.fk_cultivo=cultivo.id_cultivo 
INNER JOIN nombres_fundo ON reporte.nom_fundo=nombres_fundo.id_fundo_nombre
INNER JOIN variedad ON reporte.fk_variedad= variedad.id_variedad 
WHERE reporte.id_reporte=_idreporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_reporte_registro` (IN `_fecha_hora` DATETIME, IN `_turno` VARCHAR(15), IN `_enc_sanidad` VARCHAR(50), IN `_enc_QA` VARCHAR(50), IN `_enc_almacen` VARCHAR(50), IN `_fundo` INT, IN `_nonfundo` INT(30), IN `_lote` INT, IN `_slote` INT, IN `_cultivo` INT, IN `_variedad` INT, IN `_reserva` INT, IN `_ninstructivo` INT, IN `_pep` INT, IN `_etcultivo` INT)   INSERT INTO `reporte`( `fecha_hora`, `turno`, `enc_sanidad`, `enc_QA`, `enc_almacen`, `fk_jefe_fundo`, `nom_fundo`, `fk_lote`, `fk_slote`, `fk_cultivo`, `fk_variedad`, `aprob_jefefundo`, `aprob_jefesanidad`,reporte.aprob_jefeCalidad, reporte.nrReserva,reporte.nrInstructivo,reporte.pep,reporte.etapa_cultivo) VALUES (NOW(),_turno,_enc_sanidad,_enc_QA,_enc_almacen,_fundo,_nonfundo,_lote,_slote,_cultivo,_variedad,'No Aprobado','No Aprobado','No Aprobado',_reserva,_ninstructivo,_pep,_etcultivo)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_selloPdfJefeFundo` (IN `_idReporte` INT)   SELECT usuarios.idusuario,usuarios.sello AS sello_fundo,reporte.id_reporte
FROM usuarios 
INNER JOIN reporte ON
usuarios.idusuario = reporte.fk_jefe_fundo
WHERE reporte.id_reporte=_idReporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_selloPdfJefeSanidad` (IN `_idReporte` INT)   SELECT usuarios.idusuario,usuarios.sello AS sello_sanidad,reporte.id_reporte
FROM usuarios 
INNER JOIN reporte ON
usuarios.idusuario = reporte.fk_jefeSanidad
WHERE reporte.id_reporte=_idReporte$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_actualizarclave` (IN `_idusuario` INT, IN `_clave` VARCHAR(200))   BEGIN
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
            WHEN nivelacceso = "T" THEN "Jefe de Operaciones"
		END "nivelacceso", estado, email, codverificacion
	 FROM usuarios
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_listar` ()   BEGIN
SELECT idusuario, nombres, apellidos, nombreusuario, clave, fechacreacion, fechabaja,
CASE
WHEN nivelacceso = "A" THEN "Administrador"
WHEN nivelacceso = "C" THEN "Calidad"
WHEN nivelacceso = "J" THEN "Jefe de Fundo"
WHEN nivelacceso = "O" THEN "Operario"
WHEN nivelacceso = "T" THEN "Jefe de Operaciones"
END "nivelacceso", estado, email, codverificacion,clave
FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_login` (IN `_nombreusuario` VARCHAR(25))   BEGIN
SELECT idusuario, nombres, apellidos, nombreusuario, clave, fechacreacion, fechabaja,
CASE
WHEN nivelacceso = "A" THEN "Administrador"
WHEN nivelacceso = "C" THEN "Calidad"
WHEN nivelacceso = "J" THEN "Jefe de Fundo"
WHEN nivelacceso = "O" THEN "Operario"
WHEN nivelacceso = "T" THEN "Jefe de Operaciones"
END "nivelacceso", estado, email, codverificacion
FROM usuarios
WHERE nombreusuario = _nombreusuario AND estado = "A";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_modificar` (IN `_idusuario` INT, IN `_nombreusuario` VARCHAR(25), IN `_nivelacceso` CHAR(1), IN `_email` VARCHAR(50), IN `_password` VARCHAR(200))   BEGIN
	UPDATE usuarios SET
		nombreusuario = _nombreusuario,
		nivelacceso = _nivelacceso,
		email = _email,
        clave=_password
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_reactivar` (IN `_idusuario` INT)   BEGIN
	UPDATE usuarios SET
		fechacreacion = CURDATE(),
		fechabaja = NULL,
		estado = "A"
	WHERE idusuario = _idusuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_registro` (IN `_nombres` VARCHAR(50), IN `_apellidos` VARCHAR(50), IN `_nombreusuario` VARCHAR(25), IN `_nivelacceso` CHAR(1), IN `_email` VARCHAR(80), IN `_password` VARCHAR(200))   BEGIN
	INSERT INTO usuarios(nombres, apellidos,nombreusuario, clave, fechacreacion,fechabaja, nivelacceso, estado,  email, codverificacion)VALUES
			(_nombres, _apellidos, _nombreusuario,_password, CURDATE(), NULL, _nivelacceso, "A",_email, NULL);
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
		END "nivelacceso", estado, email, codverificacion
	 FROM usuarios
	 WHERE email =_email AND estado = "A";
END$$

DELIMITER ;

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
  `diascarencia` int(5) NOT NULL,
  `dosiscil` varchar(30) NOT NULL,
  `ncil` varchar(30) NOT NULL,
  `dosistanque` varchar(30) NOT NULL,
  `totalproducto` varchar(30) NOT NULL,
  `dosisHA` varchar(30) NOT NULL,
  `HAaplicada` varchar(30) NOT NULL,
  `gastoH2O` varchar(30) NOT NULL,
  `fkreporte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_reporte`
--

INSERT INTO `detalle_reporte` (`id_detallereporte`, `motivo_aplicacion`, `producto`, `unidad`, `diascarencia`, `dosiscil`, `ncil`, `dosistanque`, `totalproducto`, `dosisHA`, `HAaplicada`, `gastoH2O`, `fkreporte`) VALUES
(88, 11, 21, 'L', 3, '3', '3', '3', '3', '3', '33', '3', 50),
(93, 13, 23, 'KG', 2, '2', '22', '2', '2', '2', '2', '2', 51),
(94, 8, 20, 'L', 3, '3', '3', '3', '3', '3', '3', '3', 51),
(95, 15, 21, 'L', 3, '4', '4', '4', '4', '4', '4', '4', 51),
(97, 9, 23, 'KG', 2, '2', '2', '2', '2', '2', '2', '2', 52),
(98, 10, 15, 'KG', 33, '33', '3', '3', '3', '3', '3', '3', 52),
(100, 12, 21, 'L', 2, '2', '2', '2', '22', '2', '2', '2', 53),
(101, 8, 23, 'KG', 3, '3', '3', '3', '3', '3', '3', '3', 53),
(102, 12, 16, 'L', 4, '4', '4', '4', '4', '4', '4', '44', 53),
(103, 11, 11, 'L', 1, '1', '1', '1', '1', '1', '1', '1', 54),
(104, 9, 22, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 54),
(105, 9, 11, 'L', 3, '3', '3', '3', '3', '3', '3', '3', 54),
(109, 8, 23, 'KG', 1, '1', '1', '1', '1', '1', '1', '1', 60),
(110, 9, 10, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 60),
(111, 11, 13, 'KG', 3, '3', '3', '3', '3', '3', '3', '3', 60),
(112, 13, 13, 'KG', 4, '4', '4', '4', '4', '4', '4', '4', 60),
(113, 10, 24, 'KG', 1, '1', '1', '1', '1', '1', '1', '1', 61),
(114, 10, 16, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 61),
(115, 10, 25, 'L', 3, '3', '3', '3', '3', '3', '33', '3', 61),
(116, 9, 23, 'KG', 3, '3', '3', '3', '33', '3', '3', '3', 61),
(117, 19, 24, 'KG', 1, '1', '1', '1', '1', '1', '11', '1', 62),
(118, 19, 16, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 62),
(119, 19, 23, 'KG', 1, '1', '1', '1', '1', '1', '1', '1', 63),
(120, 11, 24, 'KG', 2, '2', '2', '2', '2', '2', '2', '2', 63),
(121, 13, 22, 'L', 3, '3', '3', '3', '33', '3', '3', '3', 63),
(122, 14, 25, 'L', 1, '1', '1', '1', '1', '1', '1', '1', 64),
(123, 20, 22, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 64),
(124, 20, 24, 'KG', 3, '3', '3', '3', '3', '3', '3', '3', 64),
(125, 9, 10, 'L', 1, '1', '1', '1', '11', '1', '1', '1', 66),
(126, 9, 10, 'L', 1, '1', '1', '1', '1', '1', '1', '1', 66),
(127, 11, 10, 'L', 2, '2', '22', '2', '2', '2', '2', '2', 66),
(128, 15, 10, 'L', -5, '5', '5', '5', '5', '5', '5', '5', 66),
(129, 9, 10, 'L', 3, '3', '3', '3', '3', '3', '3', '3', 66),
(130, 11, 10, 'L', -1, '2', '2', '2', '22', '2', '2', '2', 67),
(131, 13, 10, 'L', 3, '3', '3', '33', '3', '3', '3', '3', 67),
(132, 14, 10, 'L', 1, '1', '1', '1', '1', '1', '1', '1', 67),
(133, 16, 25, 'L', 4, '4', '4', '44', '4', '4', '4', '4', 67),
(134, 15, 22, 'L', 1, '1', '1', '1', '1', '1', '1', '1', 68),
(135, 12, 24, 'KG', 1, '1', '1', '1', '1', '1', '1', '1', 68),
(136, 13, 27, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 68),
(137, 20, 24, 'KG', 3, '3', '3', '3', '3', '3', '3', '3', 68),
(143, 17, 12, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 72),
(144, 12, 10, 'L', 3, '3', '3', '3', '33', '3', '3', '3', 72),
(145, 17, 10, 'L', 1, '1', '1', '1', '1', '1', '1', '1', 72),
(146, 12, 10, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 72),
(147, 12, 10, 'L', 1, '1', '1', '1', '1', '1', '1', '1', 73),
(148, 13, 10, 'L', 2, '2', '2', '2', '2', '2', '2', '2', 73),
(149, 14, 17, 'L', 3, '3', '3', '3', '3', '3', '3', '3', 73),
(150, 13, 21, 'L', 1, '1', '1', '1', '1', '1', '1', '1', 74),
(151, 20, 23, 'KG', 2, '2', '2', '2', '2', '2', '2', '2', 74),
(152, 24, 25, 'L', 3, '3', '3', '3', '3', '3', '3', '33', 74),
(153, 18, 17, 'L', 4, '4', '4', '4', '4', '4', '4', '4', 74);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etapa_cultivo`
--

CREATE TABLE `etapa_cultivo` (
  `idEcultivo` int(11) NOT NULL,
  `nombreEcultivo` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `etapa_cultivo`
--

INSERT INTO `etapa_cultivo` (`idEcultivo`, `nombreEcultivo`) VALUES
(1, 'Cosecha'),
(2, 'Mantenimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fundo`
--

CREATE TABLE `fundo` (
  `id_fundo` int(11) NOT NULL,
  `jefe_fundo` int(11) NOT NULL,
  `nombre` int(11) NOT NULL,
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
(622, 16, 1, 1, 57, 17.00, 1, 1),
(623, 16, 1, 2, 58, 21.00, 1, 1),
(624, 16, 1, 3, 59, 21.03, 1, 1),
(625, 16, 1, 4, 60, 7.87, 1, 1),
(626, 17, 1, 5, 61, 8.80, 1, 1),
(627, 17, 1, 6, 62, 18.64, 1, 1),
(628, 17, 1, 7, 63, 17.41, 1, 1),
(629, 17, 1, 8, 64, 11.65, 1, 1),
(630, 18, 1, 9, 65, 25.78, 1, 1),
(631, 18, 1, 10, 66, 26.72, 1, 1),
(632, 18, 1, 11, 67, 5.06, 1, 1),
(633, 19, 1, 12, 68, 9.30, 1, 1),
(634, 19, 1, 13, 69, 21.03, 1, 1),
(635, 19, 1, 14, 70, 17.67, 1, 1),
(636, 19, 1, 15, 71, 15.73, 1, 1),
(637, 20, 2, 16, 72, 6.36, 1, 2),
(638, 20, 2, 17, 73, 8.76, 1, 2),
(639, 20, 2, 18, 74, 8.65, 1, 2),
(640, 20, 2, 19, 75, 4.05, 1, 2),
(641, 20, 2, 20, 76, 8.54, 1, 2),
(642, 20, 2, 21, 77, 3.33, 1, 2),
(643, 20, 2, 22, 78, 7.57, 1, 2),
(644, 20, 2, 23, 79, 3.63, 1, 2),
(645, 21, 3, 24, 80, 40.00, 1, 2),
(646, 21, 3, 25, 81, 25.00, 1, 4),
(647, 22, 4, 26, 82, 0.96, 1, 4),
(648, 22, 4, 27, 83, 1.02, 1, 5),
(649, 22, 4, 28, 84, 8.51, 1, 6),
(650, 22, 4, 29, 85, 1.02, 1, 2),
(651, 22, 4, 30, 86, 1.02, 1, 8),
(652, 22, 4, 31, 87, 23.24, 5, 16),
(653, 22, 4, 32, 88, 7.00, 5, 16),
(654, 22, 4, 33, 89, 3.20, 5, 16),
(655, 23, 4, 34, 90, 10.00, 5, 17),
(656, 23, 4, 35, 91, 66.19, 5, 16),
(657, 23, 4, 36, 92, 27.19, 5, 16),
(658, 24, 5, 37, 93, 8.50, 4, 18),
(659, 24, 5, 37, 94, 12.62, 4, 18),
(660, 24, 5, 38, 95, 10.27, 4, 18),
(661, 24, 5, 38, 96, 11.61, 4, 18),
(662, 24, 5, 39, 97, 8.36, 4, 18),
(663, 24, 5, 39, 98, 9.00, 4, 18),
(664, 25, 6, 40, 99, 44.00, 6, 19),
(665, 26, 6, 41, 100, 54.41, 6, 19),
(666, 27, 6, 42, 101, 55.45, 6, 19),
(667, 25, 6, 43, 102, 20.59, 6, 19),
(668, 25, 6, 43, 102, 0.80, 6, 20),
(669, 28, 7, 44, 104, 72.40, 6, 19),
(670, 28, 7, 44, 104, 0.20, 6, 20),
(671, 27, 8, 45, 106, 12.00, 6, 19),
(672, 29, 9, 46, 107, 20.50, 10, 21),
(673, 29, 10, 47, 108, 8.00, 10, 22),
(674, 29, 11, 48, 109, 47.00, 10, 21),
(675, 29, 12, 49, 110, 10.87, 10, 21),
(676, 29, 13, 50, 111, 11.35, 10, 21),
(677, 29, 13, 51, 112, 1.80, 10, 21),
(678, 24, 5, 52, 113, 11.30, 10, 21),
(679, 29, 14, 53, 114, 26.50, 10, 21),
(680, 29, 14, 54, 115, 41.50, 10, 23),
(681, 29, 15, 55, 116, 33.00, 10, 24),
(682, 29, 15, 56, 117, 14.00, 10, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lote`
--

CREATE TABLE `lote` (
  `id_lote` int(11) NOT NULL,
  `nombre_lote` varchar(15) NOT NULL,
  `fk_fundo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lote`
--

INSERT INTO `lote` (`id_lote`, `nombre_lote`, `fk_fundo`) VALUES
(1, '1118-7', 1),
(2, '1118-8', 1),
(3, '1122-9A', 1),
(4, '1124-9B', 1),
(5, '1125-4', 1),
(6, '1116-2', 1),
(7, '1116-1', 1),
(8, '1125-6.4', 1),
(9, '1126-3', 1),
(10, '1123-5', 1),
(11, '1127', 1),
(12, '1610', 1),
(13, '1117-6.1', 1),
(14, '1117-6.2', 1),
(15, '1117-6.3', 1),
(16, '1204-6', 2),
(17, '1204-7B', 2),
(18, '1204-7A', 2),
(19, '1203-1', 2),
(20, '1203-2', 2),
(21, '1203-3', 2),
(22, '1203-4', 2),
(23, '1203-5', 2),
(24, '1150', 3),
(25, '1151', 3),
(26, '5515', 4),
(27, '5516', 4),
(28, '5517', 4),
(29, '5518', 4),
(30, '5519', 4),
(31, '1515', 4),
(32, '1516', 4),
(33, '1517', 4),
(34, '1130', 4),
(35, '1160', 4),
(36, '1710', 4),
(37, '5701', 5),
(38, '5702', 5),
(39, '5703', 5),
(40, '5401', 6),
(41, '5402', 6),
(42, '5403', 6),
(43, '5404', 6),
(44, '5810', 7),
(45, '6301', 8),
(46, '1802', 9),
(47, '1306', 10),
(48, '1901', 11),
(49, '5901', 12),
(50, '5601', 13),
(51, '5602', 13),
(52, '5710', 5),
(53, '3111', 14),
(54, '3112', 14),
(55, '3101', 15),
(56, '3102', 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivo_aplicacion`
--

CREATE TABLE `motivo_aplicacion` (
  `id_motivo` int(11) NOT NULL,
  `nombre_motivo` varchar(30) NOT NULL,
  `estado` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `motivo_aplicacion`
--

INSERT INTO `motivo_aplicacion` (`id_motivo`, `nombre_motivo`, `estado`) VALUES
(8, 'COLOR', 'A'),
(9, 'TRIPS', 'A'),
(10, 'LARVAS LEPIDOPTEROS', 'A'),
(11, 'FOLIAR', 'A'),
(12, 'CHANCHITO BLANCO', 'A'),
(13, 'OIDIUM', 'A'),
(14, 'BOTRYTIS', 'A'),
(15, 'MILDIU', 'A'),
(16, 'CRECIMIENTO DE BAYA', 'A'),
(17, 'RALEO QUIMICO', 'A'),
(18, 'ACARO', 'A'),
(19, 'CONTROL DE MALEZAS', 'A'),
(20, 'CONTROL DE NEMATODOS', 'A'),
(21, 'PUDRICION', 'A'),
(22, 'HONGO DE MADERA', 'A'),
(23, 'MADURACION', 'A'),
(24, 'BRIX', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nombres_fundo`
--

CREATE TABLE `nombres_fundo` (
  `id_fundo_nombre` int(11) NOT NULL,
  `nombre_fundo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nombres_fundo`
--

INSERT INTO `nombres_fundo` (`id_fundo_nombre`, `nombre_fundo`) VALUES
(1, 'SANTA MARGARITA'),
(2, 'SAN HILARION'),
(3, 'PROYECTO VID SANTA MARGARITA'),
(4, 'SANTA ESPERANZA'),
(5, 'SANTA LUCIA'),
(6, 'DOS MARIAS'),
(7, 'SANTA INES'),
(8, 'SANTA ISABEL'),
(9, 'SAN ISIDRO LABRADOR'),
(10, 'LUREN'),
(11, 'FORTUNA'),
(12, 'SANTA CARLA'),
(13, 'GLORIA'),
(14, 'ALPINE 511'),
(15, 'ALPINE PERU');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pep`
--

CREATE TABLE `pep` (
  `id_pep` int(11) NOT NULL,
  `nombre_pep` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pep`
--

INSERT INTO `pep` (`id_pep`, `nombre_pep`) VALUES
(3, 'Foliar'),
(4, 'Fumigación'),
(5, 'Control Etológico'),
(6, 'Mosca de la Fruta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_sanidad`
--

CREATE TABLE `productos_sanidad` (
  `id_producto` int(11) NOT NULL,
  `codigo_producto` int(11) NOT NULL,
  `nombre_producto` varchar(30) NOT NULL,
  `unidad` varchar(10) NOT NULL,
  `estado` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_sanidad`
--

INSERT INTO `productos_sanidad` (`id_producto`, `codigo_producto`, `nombre_producto`, `unidad`, `estado`) VALUES
(10, 14040845, 'ABSOLUTE 60 SC', 'L', 'A'),
(11, 14091375, 'ACAPROX', 'L', 'A'),
(12, 14025861, 'ACARSTIN', 'L', 'A'),
(13, 14014888, 'ACIDO CITRICO', 'KG', 'A'),
(14, 14032938, 'ACTARA 25W', 'KG', 'A'),
(15, 14092427, 'ACTIVOL 40 SG', 'KG', 'A'),
(16, 14090187, 'AGRIBEST', 'L', 'A'),
(17, 14092360, 'AGRIOIL 99 SL', 'L', 'A'),
(18, 14092859, 'ALEXIN PA 100 BT ENZYM LIQUIDO', 'L', 'A'),
(19, 14011770, 'ALIETTE', 'KG', 'A'),
(20, 14091935, 'AMAUTA 240 SL', 'L', 'A'),
(21, 14046562, 'AMINOLOM VITAMIN', 'L', 'A'),
(22, 14070340, 'AMINOTERRA', 'L', 'A'),
(23, 14056195, 'AMIPRID 20 SP', 'KG', 'A'),
(24, 14029701, 'AMISTAR 50 WG', 'KG', 'A'),
(25, 14042244, 'ANTI-D', 'L', 'A'),
(26, 14029655, 'AZUFRE POLVO MOJABLE', 'KG', 'A'),
(27, 14087449, 'BASFOLIAR SIZE', 'L', 'A'),
(28, 14000022, 'BAYFOLAN', 'L', 'A'),
(29, 14033305, 'BC-1000 LIQUIDO', 'L', 'A'),
(30, 14036935, 'BELLIS W G', 'KG', 'A'),
(31, 14011777, 'BENOPOINT', 'KG', 'A'),
(32, 14084506, 'BIOCINN', 'L', 'A'),
(33, 14066810, 'BIOCRECE', 'L', 'A'),
(34, 14090723, 'BIO-FORGE', 'L', 'A'),
(35, 14087819, 'BIOKARANYA', 'L', 'A'),
(36, 14088781, 'BIONEMAX (NEMATODOS X 15 MILLO', 'BOL', 'A'),
(37, 14000024, 'BIOPLUS', 'L', 'A'),
(38, 14084683, 'BIO-SPLENT 70WP', 'KG', 'A'),
(39, 14045258, 'BIOSPORE 6.4% PM', 'KG', 'A'),
(40, 14091742, 'BOTRYCCELLI', 'L', 'A'),
(41, 14084920, 'BRIX UP', 'L', 'A'),
(42, 14038236, 'BT-NOVA WP', 'KG', 'A'),
(43, 14042089, 'CALBO', 'L', 'A'),
(44, 14057842, 'CALCIO FORTE', 'L', 'A'),
(45, 14038415, 'CANTUS', 'KG', 'A'),
(46, 14023680, 'CARBOXY K', 'L', 'A'),
(47, 14057062, 'CARBOXY K X 208 L.', 'L', 'A'),
(48, 14031433, 'CARBOXY MG', 'L', 'A'),
(49, 14061953, 'CARBOXYL L X 208 L.', 'L', 'A'),
(50, 14034842, 'CENTURION', 'L', 'A'),
(51, 14091350, 'CHALANGO 250 SC', 'L', 'A'),
(52, 14041132, 'CLORFOS 48 CE', 'L', 'A'),
(53, 14082551, 'CLOSER 240 SC', 'L', 'A'),
(54, 14088396, 'COLUMBUS', 'L', 'A'),
(55, 14012501, 'CONFIDOR 350 SC', 'L', 'A'),
(56, 14084354, 'CONFIEE 325 SC', 'L', 'A'),
(57, 14085714, 'CRESCAL FE', 'KG', 'A'),
(58, 14084081, 'CRISURON', 'KG', 'A'),
(59, 14024422, 'CROP+', 'L', 'A'),
(60, 14056554, 'CROPFIELD AMINO', 'L', 'A'),
(61, 14091334, 'CROPS ZINC', 'L', 'A'),
(62, 14000040, 'CUNEB FORTE', 'L', 'A'),
(63, 14011781, 'CUPRAVIT OB', 'KG', 'A'),
(64, 14090510, 'CUSTOMBIO B5', 'L', 'A'),
(65, 14054782, 'CYTOKIN', 'L', 'A'),
(66, 14012505, 'DECIS 2.5 EC', 'L', 'A'),
(67, 14050184, 'DELTOX', 'L', 'A'),
(68, 14054860, 'DIFECON 250 EC', 'L', 'A'),
(69, 14067860, 'DITHANE FMB', 'L', 'A'),
(70, 14055050, 'DK-ESCALON', 'L', 'A'),
(71, 14035662, 'DK-TINA', 'L', 'A'),
(72, 14087709, 'DK-ZATE', 'KG', 'A'),
(73, 14078544, 'ELIPHOS', 'L', 'A'),
(74, 14086458, 'EN VIVO SC', 'L', 'A'),
(75, 14038864, 'ENERGYPHOS', 'KG', 'A'),
(76, 14019798, 'ENVIDOR 240 SC', 'L', 'A'),
(77, 14058937, 'EPICO 750 WG', 'KG', 'A'),
(78, 14040580, 'ERRASER 757', 'KG', 'A'),
(79, 14090758, 'FARMATHE', 'KG', 'A'),
(80, 14012514, 'FENKIL 3%', 'KG', 'A'),
(81, 14055229, 'FENKIL 500 EC', 'L', 'A'),
(82, 14069439, 'FEROMONA DEL BARRENADOR DE RUE', 'UN', 'A'),
(83, 14088326, 'FERTUM BOOSTER', 'L', 'A'),
(84, 14000050, 'FITOAMIN', 'L', 'A'),
(85, 14012492, 'FITOBROT', 'L', 'A'),
(86, 14067776, 'FITOKLIN', 'KG', 'A'),
(87, 14090266, 'FLEXITY', 'KG', 'A'),
(88, 14080243, 'FLUAZIL B40  EC', 'L', 'A'),
(89, 14029915, 'FOLUR', 'L', 'A'),
(90, 14011547, 'FOSFATO MONOAMONICO SOLUBLE', 'KG', 'A'),
(91, 14092403, 'FULBETA PLUS', 'L', 'A'),
(92, 14049190, 'FULLPACK', 'L', 'A'),
(93, 14066754, 'GRANFURAN', 'L', 'A'),
(94, 14062179, 'GREEN MAGNESIO', 'L', 'A'),
(95, 14091218, 'GROWS-CYT', 'L', 'A'),
(96, 14085159, 'HONGOS PAECILOMYCES LILACINUS', 'KG', 'A'),
(97, 14030089, 'HORMONA DK GIB TAB', 'UN', 'A'),
(98, 14023166, 'HUNTER', 'L', 'A'),
(99, 14086890, 'HURAKAN', 'L', 'A'),
(100, 14092423, 'IDAI COBRE', 'L', 'A'),
(101, 14087451, 'IKARO', 'KG', 'A'),
(102, 14064056, 'JAKE 200 SL', 'L', 'A'),
(103, 14089021, 'KADONDO-AG', 'KG', 'A'),
(104, 14000065, 'KAMAB 26', 'KG', 'A'),
(105, 14050387, 'KARBOXYLATO DE POTASIO', 'L', 'A'),
(106, 14089884, 'KATSU 5% EW', 'L', 'A'),
(107, 14088740, 'KELMAX', 'L', 'A'),
(108, 14032674, 'KELPAK', 'L', 'A'),
(109, 14012528, 'KLERAT PELLET', 'KG', 'A'),
(110, 14045867, 'K-ÑON', 'L', 'A'),
(111, 14044011, 'KOLBRIX', 'L', 'A'),
(112, 14090550, 'KUARTEL', 'L', 'A'),
(113, 14064300, 'LEPIBAC 10 PM', 'KG', 'A'),
(114, 14090935, 'L-ESPECIALISTA 230 SC', 'L', 'A'),
(115, 14089086, 'MASADA 48 SC', 'L', 'A'),
(116, 14091936, 'MATICIN 240 SL', 'L', 'A'),
(117, 14020516, 'MELAZA DE CAÑA', 'KG', 'A'),
(118, 14084022, 'MENTOR 750 WG', 'KG', 'A'),
(119, 14045120, 'MERTECT 500 SC', 'L', 'A'),
(120, 14088453, 'METARRANCH MZ 58 WP', 'KG', 'A'),
(121, 14088892, 'METHA-CONTROL', 'KG', 'A'),
(122, 14033980, 'METHOMYL', 'KG', 'A'),
(123, 14012539, 'MICROTHIOL SPECIAL', 'KG', 'A'),
(124, 14065786, 'MOVAXION', 'L', 'A'),
(125, 14047738, 'MOVENTO', 'L', 'A'),
(126, 14011552, 'NATURAMIN PLUS', 'L', 'A'),
(127, 14011553, 'NATURAMIN ZINC', 'L', 'A'),
(128, 14089495, 'NATURMIX-L', 'L', 'A'),
(129, 14059552, 'NIM 700', 'L', 'A'),
(130, 14084430, 'NIMROD', 'L', 'A'),
(131, 14011798, 'NISSORUN 10% WP', 'KG', 'A'),
(132, 14025267, 'NITRATE BALANCER', 'L', 'A'),
(133, 14011554, 'NITRATO DE AMONIO', 'KG', 'A'),
(134, 14011555, 'NITRATO DE CALCIO', 'KG', 'A'),
(135, 14011556, 'NITRATO DE MAGNESIO', 'KG', 'A'),
(136, 14011557, 'NITRATO DE POTASIO CRISTALIZAD', 'KG', 'A'),
(137, 14041937, 'NU FILM', 'L', 'A'),
(138, 14040962, 'NUTRI CALCIO', 'L', 'A'),
(139, 14040961, 'NUTRI MAGNESIO', 'L', 'A'),
(140, 14070476, 'PACKHARD', 'L', 'A'),
(141, 14069437, 'PANTERA DETER AP35', 'L', 'A'),
(142, 14066462, 'PANTERA OIL VEGETAL', 'L', 'A'),
(143, 14029143, 'PANTERA PROCESADO', 'KG', 'A'),
(144, 14011803, 'PHYTON - 27', 'L', 'A'),
(145, 14028806, 'POLYRAM DF', 'KG', 'A'),
(146, 14000090, 'PREP 720', 'L', 'A'),
(147, 14078543, 'PRIX', 'L', 'A'),
(148, 14049046, 'PRO PHYT', 'L', 'A'),
(149, 14087032, 'PROPERTY 300 SC', 'L', 'A'),
(150, 14018732, 'PROSPER 500 EC', 'L', 'A'),
(151, 14043318, 'PROTONE 10 SL', 'L', 'A'),
(152, 14086647, 'PYRINEX 48 EC', 'L', 'A'),
(153, 14088582, 'QUELA-MAN', 'L', 'A'),
(154, 14088587, 'QUELA-ZINC', 'L', 'A'),
(155, 14086940, 'RANKILL 500', 'L', 'A'),
(156, 14079751, 'RANMAN', 'L', 'A'),
(157, 14089082, 'RAYKAT ENRAIZADOR', 'L', 'A'),
(158, 14052814, 'ROOTCHEM', 'L', 'A'),
(159, 14027482, 'ROOTING', 'L', 'A'),
(160, 14055546, 'RYZOFIT', 'L', 'A'),
(161, 14086391, 'SANIX PLUS', 'KG', 'A'),
(162, 14057090, 'SANTIMEC', 'L', 'A'),
(163, 14021895, 'SCORE 250 EC', 'L', 'A'),
(164, 14091349, 'SEGURITE 625 WG', 'KG', 'A'),
(165, 14045455, 'SELECRON 500 EC', 'L', 'A'),
(166, 14022851, 'SETT FIX', 'L', 'A'),
(167, 14037335, 'SIAPTON', 'L', 'A'),
(168, 14051749, 'SINES-3 MADUREX', 'KG', 'A'),
(169, 14063384, 'SKIRLA', 'KG', 'A'),
(170, 14000098, 'SOLUBOR', 'KG', 'A'),
(171, 14090779, 'SPECIAL', 'L', 'A'),
(172, 14069592, 'SPEEDFOL COLOUR', 'KG', 'A'),
(173, 14075810, 'SPEEDFOL PECANO', 'KG', 'A'),
(174, 14058877, 'SPIROSIL 250 SC', 'L', 'A'),
(175, 14040953, 'STRONSIL 50 WG', 'KG', 'A'),
(176, 14044813, 'SUCCESSOR SC', 'L', 'A'),
(177, 14011562, 'SULFATO DE CU', 'KG', 'A'),
(178, 14011564, 'SULFATO DE MAGNESIO CRISTALIZA', 'KG', 'A'),
(179, 14011567, 'SULFATO DE POTASIO SOLUBLE', 'KG', 'A'),
(180, 14011569, 'SULFATO DE ZINC', 'KG', 'A'),
(181, 14086116, 'SULFLIQ', 'L', 'A'),
(182, 14011814, 'SULFODIN', 'KG', 'A'),
(183, 14089493, 'SULMAT 480 EC', 'L', 'A'),
(184, 14090281, 'SUPER POTASIO', 'L', 'A'),
(185, 14062720, 'SUPER-A 450 EC', 'L', 'A'),
(186, 14088072, 'SURROUND WP', 'KG', 'A'),
(187, 14048226, 'SWITCH 62.5 WG', 'KG', 'A'),
(188, 14056792, 'SYSTEMIC', 'L', 'A'),
(189, 14078546, 'TELDOR SC', 'L', 'A'),
(190, 14043262, 'TEMO-O-CID', 'L', 'A'),
(191, 14040232, 'TENAZ 250 EW', 'L', 'A'),
(192, 14023293, 'TERRASORB FOLIAR', 'L', 'A'),
(193, 14063732, 'THIDIAZURON 50 % WP', 'KG', 'A'),
(194, 14081840, 'TOPSIL 150 SC', 'L', 'A'),
(195, 14090938, 'TOVLI 20 SL', 'L', 'A'),
(196, 14023727, 'TRACER 120 SC', 'L', 'A'),
(197, 14084078, 'TRECKER', 'KG', 'A'),
(198, 14091041, 'T-REX 360 SL', 'L', 'A'),
(199, 14011819, 'TRIFMINE 30% PMB', 'KG', 'A'),
(200, 14083153, 'TRITEK', 'L', 'A'),
(201, 14032841, 'TRIUNFO', 'KG', 'A'),
(202, 14011571, 'UREA', 'KG', 'A'),
(203, 14085117, 'VAPOR GARD', 'L', 'A'),
(204, 14011820, 'VERTIMEC', 'L', 'A'),
(205, 14011822, 'VYDAN', 'L', 'A'),
(206, 14086650, 'XTEND', 'KG', 'A'),
(207, 14084385, 'ZAMPRO DM', 'L', 'A'),
(208, 14011573, 'ZIFERMAN', 'L', 'A'),
(209, 14088999, 'ZORVEC ENCANTIA', 'L', 'A'),
(210, 14012559, 'SUPERMILL 90 PS', 'KG', 'A'),
(211, 14024742, 'TIFON 2.5 % PS', 'KG', 'A'),
(212, 14090004, 'BASFOLIAR ZN PREMIUM SL', 'L', 'A'),
(213, 14091583, 'INVELOP', 'KG', 'A'),
(214, 14089034, 'RITMO', 'L', 'A'),
(215, 14085464, 'METHOMYL 90% SP', 'KG', 'A'),
(216, 14000053, 'GF-120', 'L', 'A'),
(217, 14043221, 'TRAMPAS MC JAKSON', 'UN', 'A'),
(218, 14075125, 'CERATRAP', 'L', 'A'),
(219, 14087886, 'MOSQUERO CONETRAP', 'UN', 'A'),
(220, 14091444, 'TRAMPA MCPHALL-30', 'UN', 'A'),
(221, 14092108, 'TRYPACK', 'UN', 'A'),
(222, 14092693, 'TML PLUG (FEROMONE TRIMEDLURE)', 'UN', 'A'),
(223, 14017233, 'BIOLURE', 'UN', 'A'),
(224, 14092335, 'CHECKMATE VMB-XL (BALDE X 1000', 'UN', 'A'),
(225, 14064016, 'GOLDEN NATURAL OIL', 'L', 'A'),
(226, 14070843, 'LAMINA PEGANTE AMARILLA-JACKSO', 'UN', 'A'),
(227, 14011812, 'SULCOPENTA', 'L', 'A'),
(228, 14064860, 'ACARISIL 110 SC', 'L', 'A'),
(229, 14034427, 'HUMICOP', 'L', 'A'),
(230, 14081894, 'KOLTAR SC', 'L', 'A'),
(231, 14092334, 'GALIGAN 240 EC', 'L', 'A'),
(232, 14087723, 'CROPS-CANELA', 'L', 'A'),
(233, 14024730, 'AGROCIMAX PLUS', 'L', 'A'),
(234, 14089029, 'AMINO Q-S', 'L', 'A'),
(235, 14089797, 'STIMPLEX - G', 'L', 'A'),
(236, 14076143, 'KALIGREEN', 'KG', 'A'),
(237, 14089360, 'TRICHO CONTROL', 'KG', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividad_detalle`
--

CREATE TABLE `registro_actividad_detalle` (
  `id_RDreporte` int(11) NOT NULL,
  `RDFecha` datetime NOT NULL,
  `RDnombres` text NOT NULL,
  `RDcodigo_reporte` int(11) NOT NULL,
  `RDaccion` text NOT NULL,
  `RDobservacion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_actividad_detalle`
--

INSERT INTO `registro_actividad_detalle` (`id_RDreporte`, `RDFecha`, `RDnombres`, `RDcodigo_reporte`, `RDaccion`, `RDobservacion`) VALUES
(1, '2024-01-31 12:22:00', 'Operario Operario', 62, 'Eliminar', 'aaaa'),
(2, '2024-02-01 11:32:15', 'Administrador Administrador', 69, 'Eliminar', 'Error de digitacion de producto'),
(3, '2024-02-01 11:32:33', 'Administrador Administrador', 67, 'Eliminar', 'Error de motivo'),
(4, '2024-02-01 22:55:52', 'Administrador Administrador', 87, 'Eliminar', 'Se agrego un producto por error'),
(5, '2024-02-01 23:08:40', 'Administrador Administrador', 85, 'Eliminar', 'xd'),
(6, '2024-02-01 23:16:07', 'Administrador Administrador', 86, 'Eliminar', 'z'),
(7, '2024-02-01 23:16:48', 'Administrador Administrador', 84, 'Eliminar', 'n'),
(8, '2024-02-01 23:31:10', 'Administrador Administrador', 90, 'Eliminar', 'e'),
(9, '2024-02-01 23:31:29', 'Administrador Administrador', 91, 'Eliminar', 'y'),
(10, '2024-02-02 06:56:08', 'Administrador Administrador', 96, 'Eliminar', 'Error al seleccionar producto'),
(11, '2024-02-02 06:56:41', 'Administrador Administrador', 99, 'Eliminar', 'Error en cantidad del producto'),
(12, '2024-02-02 07:15:27', 'Administrador Administrador', 92, 'Eliminar', 'e');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividad_reporte`
--

CREATE TABLE `registro_actividad_reporte` (
  `id_ARreporte` int(11) NOT NULL,
  `ARfecha` datetime NOT NULL,
  `ARnombres` text NOT NULL,
  `ARcodigo_reporte` int(11) NOT NULL,
  `ARaccion` text NOT NULL,
  `ARobservacion` text NOT NULL,
  `antes` text DEFAULT NULL,
  `despues` text DEFAULT NULL,
  `eliminar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_actividad_reporte`
--

INSERT INTO `registro_actividad_reporte` (`id_ARreporte`, `ARfecha`, `ARnombres`, `ARcodigo_reporte`, `ARaccion`, `ARobservacion`, `antes`, `despues`, `eliminar`) VALUES
(1, '2024-01-31 09:43:26', 'Administrador Administrador', 37, 'Eliminar', 'ninguna', NULL, NULL, ''),
(2, '2024-01-31 10:32:05', 'Administrador Administrador', 39, 'Eliminar', 'Observacion', NULL, NULL, ''),
(3, '2024-01-31 10:56:14', 'b', 0, 'Modificar', '36', NULL, NULL, ''),
(4, '2024-01-31 11:00:49', 'sssssd', 12, 'Modificar', 'dsssdsds', NULL, NULL, ''),
(5, '2024-01-31 11:02:12', 'Administrador Administrador', 36, 'Modificar', 'ninguna', NULL, NULL, ''),
(6, '2024-02-01 08:57:57', 'Administrador Administrador', 41, 'Modificar', 'Error de confusion con el jefe de fundo', NULL, NULL, ''),
(7, '2024-02-01 09:12:09', 'Administrador Administrador', 42, 'Modificar', 'Error de digitacion de jefe de fundo', NULL, NULL, ''),
(8, '2024-02-01 11:10:27', 'Administrador Administrador', 25, 'Modificar', 'Error de digitacion de jefe de fundo', NULL, NULL, ''),
(9, '2024-02-01 11:22:43', 'Administrador Administrador', 40, 'Modificar', 'Error de digitacion de jefe de fundo', NULL, NULL, ''),
(10, '2024-02-01 22:35:01', 'Administrador Administrador', 49, 'Modificar', 'Error digitacion jefe de fundo', NULL, NULL, ''),
(11, '2024-02-02 06:54:50', 'Administrador Administrador', 51, 'Modificar', 'Error al seleccionar jefe de fundo', NULL, NULL, ''),
(12, '2024-02-02 19:50:01', 'Administrador Administrador', 51, 'Modificar', 'error de digitacion de lote', NULL, NULL, ''),
(13, '2024-02-02 19:53:03', 'Administrador Administrador', 51, 'Modificar', 'Error de digitacion de jefe de fundo', NULL, NULL, ''),
(14, '2024-02-03 07:56:20', 'Administrador Administrador', 51, 'Modificar', 'quiero', NULL, NULL, ''),
(15, '2024-02-03 07:56:52', 'Administrador Administrador', 51, 'Modificar', 'x', NULL, NULL, ''),
(16, '2024-02-03 09:30:14', 'Administrador Administrador', 47, 'Modificar', 'ninguna', NULL, NULL, ''),
(17, '2024-02-03 13:17:10', 'Administrador Administrador', 59, 'Eliminar', '2024-02-03', NULL, NULL, ''),
(18, '2024-02-05 19:42:18', 'Administrador Administrador', 75, 'Eliminar', 'k', NULL, NULL, ''),
(19, '2024-02-06 12:39:03', 'Administrador Administrador', 76, 'Modificar', 'zzzzz', NULL, NULL, ''),
(20, '2024-02-06 12:42:35', 'Administrador Administrador', 69, 'Modificar', 'AAAAAAAAA', NULL, NULL, ''),
(21, '2024-02-06 12:44:57', 'Administrador Administrador', 73, 'Modificar', 'AAAAAAAAAAA', NULL, NULL, ''),
(22, '2024-02-06 12:47:14', 'Administrador Administrador', 70, 'Modificar', 'eeeeeeeee', NULL, NULL, ''),
(23, '2024-02-06 13:22:19', 'Administrador Administrador', 72, 'Modificar', 'tttt', NULL, NULL, ''),
(24, '2024-02-06 13:24:26', 'Administrador Administrador', 69, 'Modificar', 'eee', NULL, NULL, ''),
(25, '2024-02-06 13:39:36', 'Administrador Administrador', 69, 'Modificar', 'eeee', NULL, NULL, ''),
(26, '2024-02-06 13:41:22', 'Administrador Administrador', 69, 'Modificar', 'rrrrrrr', NULL, NULL, ''),
(27, '2024-02-06 13:52:28', 'Administrador Administrador', 70, 'Modificar', 'sssss', NULL, NULL, ''),
(28, '2024-02-06 23:20:45', 'Administrador Administrador', 69, 'Modificar', 'aaaa', NULL, NULL, ''),
(29, '2024-02-06 23:30:14', 'Administrador Administrador', 70, 'Modificar', 'e', NULL, NULL, ''),
(30, '2024-02-06 23:37:19', 'Administrador Administrador', 69, 'Modificar', 'p', NULL, NULL, ''),
(31, '2024-02-06 23:54:40', 'Administrador Administrador', 76, 'Modificar', 'p', NULL, NULL, ''),
(32, '2024-02-06 23:55:29', 'Administrador Administrador', 69, 'Modificar', 'pp', NULL, NULL, ''),
(33, '2024-02-06 23:56:52', 'Administrador Administrador', 69, 'Modificar', 'i', NULL, NULL, ''),
(34, '2024-02-07 00:08:32', 'Administrador Administrador', 47, 'Modificar', 'i', NULL, NULL, ''),
(35, '2024-02-07 00:10:06', 'Administrador Administrador', 47, 'Modificar', 'j', NULL, NULL, ''),
(36, '2024-02-07 00:15:07', 'Administrador Administrador', 47, 'Modificar', 'e', NULL, NULL, ''),
(37, '2024-02-07 00:24:17', 'Administrador Administrador', 48, 'Modificar', 'w', NULL, NULL, ''),
(38, '2024-02-07 00:29:19', 'Administrador Administrador', 47, 'Modificar', 'i', NULL, NULL, ''),
(39, '2024-02-07 00:42:59', 'Administrador Administrador', 47, 'Modificar', 'z', NULL, NULL, ''),
(40, '2024-02-07 00:53:04', 'Administrador Administrador', 48, 'Modificar', 'porque quiero', 'enc_sanidad=a\nenc_almacen=bbbbbbbbbbbb\nnom_fundo=SANTA CARLA\nfk_lote=5901\nfk_slote=5901\nfk_variedad=UC 157\nnrInstructivo=0\n', 'enc_sanidad=marcos\nenc_almacen=jeriot\nnom_fundo=LUREN\nfk_lote=1306\nfk_slote=1306\nfk_variedad=Atlas\nnrInstructivo=15\n', ''),
(41, '2024-02-07 06:27:44', 'Administrador Administrador', 47, 'Modificar', 'p', 'fk_lote=1117-6.1\nfk_slote=6.1\n', 'fk_lote=1117-6.3\nfk_slote=6.3\n', ''),
(42, '2024-02-07 07:41:56', 'Administrador Administrador', 48, 'Modificar', 'ssss', 'nrReserva=0\n', 'nrReserva=10\n', ''),
(43, '2024-02-07 07:43:40', 'Administrador Administrador', 49, 'Modificar', 'cambio de datos', 'enc_QA=n<br>nrReserva=0<br>nrInstructivo=0\n', 'enc_QA=jose<br>nrReserva=15<br>nrInstructivo=60\n', ''),
(44, '2024-02-07 08:50:44', 'Administrador Administrador', 48, 'Modificar', 'Observacion de Sanidad', 'enc_almacen=jeriot<br>nrInstructivo=15<br>etapa_cultivo=Cosecha<br>', 'enc_almacen=Pablo<br>nrInstructivo=50<br>etapa_cultivo=Mantenimiento<br>', ''),
(45, '2024-02-07 08:53:50', 'Administrador Administrador', 47, 'Modificar', 'error en numero de reserva', 'enc_QA=eeeee<br>enc_almacen=jjjjjj<br>nrReserva=15<br>', 'enc_QA=minerva<br>enc_almacen=jerico<br>nrReserva=1452<br>', ''),
(46, '2024-02-07 08:58:19', 'Administrador Administrador', 48, 'Modificar', 'ERROR DE NR DE RESERVA Y PEP', 'nrReserva=10<br>pep=Foliar<br>', 'nrReserva=1850<br>pep=Fumigación<br>', ''),
(47, '2024-02-07 08:59:46', 'Administrador Administrador', 47, 'Eliminar', 'REPORTE NO VALIDO', NULL, NULL, ''),
(48, '2024-02-07 09:40:01', 'Administrador Administrador', 48, 'Eliminar', 't', NULL, NULL, NULL),
(49, '2024-02-07 09:43:52', 'Administrador Administrador', 70, 'Eliminar', 'w', NULL, NULL, 'p<br>p<br>p<br>Roque Sifuentes<br>SANTA MARGARITA<br>1118-7<br>1<br>Vid<br>Red Globe<br>8<br>8<br>Fumigación<br>Mantenimiento'),
(50, '2024-02-07 09:53:47', 'Administrador Administrador', 71, 'Eliminar', 'CREACION INVALIDA', NULL, NULL, 'enc_sanidad: ñ<br>enc_QA: ñ<br>enc_almacen: ñ<br>fk_jefe_fundo: Amadeo Acuña<br>nom_fundo: SANTA MARGARITA<br>fk_lote: 1118-7<br>fk_slote: 1<br>fk_cultivo: Vid<br>fk_variedad: Red Globe<br>nrReserva: 4<br>nrInstructivo: 4<br>pep: Foliar<br>etapa_cultivo: Cosecha<br>');

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
  `fk_jefeSanidad` int(11) DEFAULT NULL,
  `nom_fundo` int(11) NOT NULL,
  `fk_lote` int(11) NOT NULL,
  `fk_slote` int(11) NOT NULL,
  `fk_cultivo` int(11) NOT NULL,
  `fk_variedad` int(11) NOT NULL,
  `aprob_jefefundo` varchar(15) NOT NULL,
  `aprob_jefesanidad` varchar(15) NOT NULL,
  `aprob_jefeCalidad` varchar(15) NOT NULL,
  `fecha_llegada` date DEFAULT NULL,
  `pep` int(11) NOT NULL,
  `nrReserva` int(11) NOT NULL,
  `nrInstructivo` int(11) NOT NULL,
  `etapa_cultivo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reporte`
--

INSERT INTO `reporte` (`id_reporte`, `fecha_hora`, `turno`, `enc_sanidad`, `enc_QA`, `enc_almacen`, `fk_jefe_fundo`, `fk_jefeSanidad`, `nom_fundo`, `fk_lote`, `fk_slote`, `fk_cultivo`, `fk_variedad`, `aprob_jefefundo`, `aprob_jefesanidad`, `aprob_jefeCalidad`, `fecha_llegada`, `pep`, `nrReserva`, `nrInstructivo`, `etapa_cultivo`) VALUES
(50, '2024-02-01 22:24:35', 'Noche', 'b', 'b', 'b', 16, NULL, 1, 1, 57, 1, 1, 'Aprobado', 'Aprobado', 'Aprobado', NULL, 3, 0, 0, 1),
(51, '2024-02-02 06:48:57', 'Mañana', '1', '1', '1', 17, NULL, 1, 5, 61, 1, 1, 'No Aprobado', 'No Aprobado', 'No Aprobado', NULL, 4, 22222222, 22222222, 2),
(52, '2024-02-02 06:49:15', 'Mañana', 'b', 'b', 'b', 26, NULL, 6, 41, 100, 6, 19, 'Aprobado', 'Aprobado', 'Aprobado', '2024-02-03', 3, 0, 0, 1),
(53, '2024-02-02 06:49:42', 'Mañana', 'p', 'p', 'p', 27, NULL, 6, 42, 101, 6, 19, 'No Aprobado', 'Aprobado', 'No Aprobado', NULL, 3, 0, 0, 1),
(54, '2024-02-02 06:57:41', 'Mañana', 'aaa', 'a', 'a', 18, NULL, 1, 9, 65, 1, 1, 'No Aprobado', 'Aprobado', 'No Aprobado', NULL, 3, 0, 0, 1),
(55, '2024-02-02 11:38:50', 'Mañana', 'a', 'a', 'a', 25, NULL, 6, 43, 102, 6, 19, 'Aprobado', 'No Aprobado', 'No Aprobado', NULL, 3, 0, 0, 1),
(56, '2024-02-02 11:39:11', 'Mañana', 'b', 'bb', 'b', 17, NULL, 1, 5, 61, 1, 1, 'No Aprobado', 'No Aprobado', 'No Aprobado', NULL, 3, 0, 0, 1),
(57, '2024-02-02 11:40:14', 'Mañana', 't', 't', 't', 21, NULL, 3, 24, 80, 1, 2, 'No Aprobado', 'No Aprobado', 'No Aprobado', NULL, 3, 0, 0, 1),
(58, '2024-02-02 14:04:26', 'Tarde', '1', '1', '1', 27, NULL, 6, 42, 101, 6, 19, 'No Aprobado', 'No Aprobado', 'No Aprobado', NULL, 3, 1111, 22222, 2),
(60, '2024-02-03 08:12:41', 'Mañana', 'Martin', 'Fabian', 'Jesus', 21, NULL, 3, 24, 80, 1, 2, 'Aprobado', 'Aprobado', 'Aprobado', '2024-02-02', 3, 1234, 5013, 2),
(61, '2024-02-03 08:15:12', 'Mañana', 'a', 'a', 'a', 16, NULL, 1, 1, 57, 1, 1, 'Aprobado', 'Aprobado', 'Aprobado', '2024-02-03', 3, 4, 4, 2),
(62, '2024-02-03 08:15:37', 'Mañana', 'b', 'bb', 'bb', 16, NULL, 1, 1, 57, 1, 1, 'Aprobado', 'Aprobado', 'Aprobado', '2024-01-29', 3, 8, 8, 1),
(63, '2024-02-03 08:16:04', 'Mañana', 'h', 'h', 'h', 24, NULL, 5, 37, 94, 4, 18, 'Aprobado', 'Aprobado', 'Aprobado', NULL, 3, 45, 4, 2),
(64, '2024-02-03 08:16:28', 'Mañana', 'm', 'm', 'm', 20, NULL, 2, 22, 78, 1, 2, 'Aprobado', 'Aprobado', 'Aprobado', NULL, 4, 5, 5, 1),
(65, '2024-02-03 10:23:11', 'Mañana', 'Martin', 'Miguel', 'Jose', 22, NULL, 4, 31, 87, 5, 16, 'No Aprobado', 'Aprobado', 'No Aprobado', NULL, 5, 1152, 8745, 2),
(66, '2024-02-05 06:23:25', 'Mañana', 'aAaA', 'a', 'a', 19, NULL, 1, 12, 68, 1, 1, 'Aprobado', 'Aprobado', 'Aprobado', '2024-02-06', 3, 51515, 51, 2),
(67, '2024-02-05 06:24:13', 'Mañana', 'b', 'b', 'b', 25, NULL, 6, 40, 99, 6, 19, 'Aprobado', 'Aprobado', 'Aprobado', '2024-02-05', 4, 7878, 8787, 2),
(68, '2024-02-05 06:24:30', 'Mañana', 'i', 'i', 'i', 22, NULL, 4, 28, 84, 1, 6, 'Aprobado', 'Aprobado', 'Aprobado', NULL, 3, 8, 8, 1),
(69, '2024-02-06 06:25:00', 'Mañana', 'jjjjjjjjj', 'eeeeeeeeeee', 'p', 19, NULL, 1, 14, 70, 1, 1, 'No Aprobado', 'No Aprobado', 'No Aprobado', NULL, 3, 788, 887, 1),
(72, '2024-02-07 19:22:18', 'Mañana', 'h', 'h', 'h', 20, NULL, 2, 18, 74, 1, 2, 'No Aprobado', 'Aprobado', 'No Aprobado', NULL, 4, 6, 6, 1),
(73, '2024-02-07 19:22:18', 'Mañana', 'AAAAAAAA', 'eAAAAAAAAAA', 'eAAAAAAAAAAAA', 16, NULL, 1, 1, 57, 1, 1, 'No Aprobado', 'Aprobado', 'No Aprobado', NULL, 3, 3, 3, 2),
(74, '2024-02-07 19:22:18', 'Mañana', 'q', 'q', 'q', 16, NULL, 1, 1, 57, 1, 1, 'No Aprobado', 'Aprobado', 'No Aprobado', NULL, 3, 8, 8, 1),
(76, '2024-02-07 19:22:18', 'Mañana', '1', '1', '1', 29, NULL, 10, 47, 108, 10, 22, 'No Aprobado', 'Aprobado', 'No Aprobado', NULL, 5, 1, 1, 1);

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
  `clave` varchar(200) NOT NULL,
  `fechacreacion` date NOT NULL,
  `fechabaja` date DEFAULT NULL,
  `nivelacceso` char(1) NOT NULL,
  `estado` char(1) NOT NULL,
  `sello` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `codverificacion` char(6) DEFAULT NULL,
  `fk_jOperaciones` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `nombres`, `apellidos`, `nombreusuario`, `clave`, `fechacreacion`, `fechabaja`, `nivelacceso`, `estado`, `sello`, `email`, `codverificacion`, `fk_jOperaciones`) VALUES
(13, 'Administrador', 'Administrador', 'Administrador', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-31', NULL, 'A', 'A', '', 'admin@admin.com', NULL, NULL),
(16, 'Amadeo', 'Acuña', 'aacuña', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-02-02', NULL, 'J', 'A', '20240126021435.jpg', 'uva1s@beta.com', NULL, 47),
(17, 'Roberto', 'Bernales', 'rbernales', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-02-02', NULL, 'J', 'A', '20240125071905.jpg', 'uva1s@beta.com', NULL, 47),
(18, 'Roque', 'Sifuentes', 'rsifuentes', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-25', NULL, 'J', 'A', '20240125071919.jpg', 'uva1s@beta.com', NULL, 48),
(19, 'Silverio', 'Ccoyori', 'sccoyori', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 47),
(20, 'Gary', 'Trujillo', 'gtrujillo', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 49),
(21, 'Miguel', 'Deunis', 'mdeunis', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 49),
(22, 'Fernando', 'Cabrera', 'fcabrera', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 47),
(23, 'Javier', 'Medina', 'jmedina', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 48),
(24, 'Rony', 'Laura', 'rlaura', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 48),
(25, 'Karina', 'Torres', 'ktorres', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 47),
(26, 'Eder', 'Razabal', 'erazabal', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '20240125071954.jpg', 'uva1s@beta.com', NULL, 48),
(27, 'Ricardo', 'Velarde', 'rvelarde', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 49),
(28, 'Miguel', 'Vallardares', 'mvallardares', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '20240126041603.jpg', 'uva1s@beta.com', NULL, 49),
(29, 'Gino', 'Rosas', 'grosas', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-16', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 48),
(32, 'Operario', 'Operario', 'Operario', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-17', NULL, 'O', 'A', '', 'uva1s@beta.com', NULL, NULL),
(33, 'Calidad', 'Calidad', 'Calidad', '$2y$10$dvgzm2Jmh0u98DerZSGkX.QH5rVqqD/ctSC3UCgYNj4jFh0CgR5mi', '2024-01-17', NULL, 'C', 'A', '', 'uva1s@beta.com', NULL, NULL),
(47, 'Jeriot', 'Magallanes Hernandez', 'jmagallanes', '$2y$10$lBwTRRGcfq9nd5ROgfKlXe2AnqoRbmmaU.NqXslI4MKpJIkMElduC', '2024-02-02', NULL, 'T', 'A', '', 'uva1s@beta.com', NULL, NULL),
(48, 'Jesus', 'Peve', 'jpeve', '$2y$10$I3HDLe6R/2myastDm8dNH.GLd7S.h/5iSSiQGqf5UuG9QG5syh5NK', '2024-02-02', NULL, 'T', 'A', '', 'uva1s@beta.com', NULL, NULL),
(49, 'Brenda', 'Minaya', 'jminaya', '$2y$10$VrsCTwKXPgjnjcQ3ihX3rOEutoZGgC2Z/tV5994AbShRBJ5qgIQ1S', '2024-02-02', NULL, 'T', 'A', '', 'uva1s@beta.com', NULL, NULL),
(50, 'a', 'a', 'a', '$2y$10$K1bwhozx2VqfZYFbW/3js.a046l9fHiyu3zIwR88vKlDkYrCxB3kK', '2024-02-05', NULL, 'J', 'A', '', 'uva1s@beta.com', NULL, 52),
(52, 'ab', 'ab', 'ab', '$2y$10$CV7La93XcRCoOfM8VSRcCebbnse7IXd8QFF8F1TMOhPjeNPSEJlXq', '2024-02-05', NULL, 'T', 'A', '', 'uva1s@beta.com', NULL, NULL);

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

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `etapa_cultivo`
--
ALTER TABLE `etapa_cultivo`
  ADD PRIMARY KEY (`idEcultivo`);

--
-- Indices de la tabla `fundo`
--
ALTER TABLE `fundo`
  ADD PRIMARY KEY (`id_fundo`),
  ADD KEY `jefe_fundo` (`jefe_fundo`),
  ADD KEY `cultivo` (`cultivo`),
  ADD KEY `variedad` (`variedad`),
  ADD KEY `lote` (`lote`,`s_lote`),
  ADD KEY `s_lote` (`s_lote`),
  ADD KEY `nombre` (`nombre`);

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
-- Indices de la tabla `nombres_fundo`
--
ALTER TABLE `nombres_fundo`
  ADD PRIMARY KEY (`id_fundo_nombre`);

--
-- Indices de la tabla `pep`
--
ALTER TABLE `pep`
  ADD PRIMARY KEY (`id_pep`);

--
-- Indices de la tabla `productos_sanidad`
--
ALTER TABLE `productos_sanidad`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `registro_actividad_detalle`
--
ALTER TABLE `registro_actividad_detalle`
  ADD PRIMARY KEY (`id_RDreporte`);

--
-- Indices de la tabla `registro_actividad_reporte`
--
ALTER TABLE `registro_actividad_reporte`
  ADD PRIMARY KEY (`id_ARreporte`);

--
-- Indices de la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD PRIMARY KEY (`id_reporte`),
  ADD KEY `fk_jefe_fundo` (`fk_jefe_fundo`,`fk_lote`,`fk_slote`,`fk_cultivo`,`fk_variedad`),
  ADD KEY `fk_cultivo` (`fk_cultivo`),
  ADD KEY `fk_variedad` (`fk_variedad`),
  ADD KEY `fk_lote` (`fk_lote`),
  ADD KEY `fk_slote` (`fk_slote`),
  ADD KEY `fk_jefeSanidad` (`fk_jefeSanidad`),
  ADD KEY `nom_fundo` (`nom_fundo`),
  ADD KEY `pep` (`pep`),
  ADD KEY `etapa_cultivo` (`etapa_cultivo`);

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
-- AUTO_INCREMENT de la tabla `cultivo`
--
ALTER TABLE `cultivo`
  MODIFY `id_cultivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_reporte`
--
ALTER TABLE `detalle_reporte`
  MODIFY `id_detallereporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT de la tabla `etapa_cultivo`
--
ALTER TABLE `etapa_cultivo`
  MODIFY `idEcultivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `fundo`
--
ALTER TABLE `fundo`
  MODIFY `id_fundo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=687;

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
-- AUTO_INCREMENT de la tabla `nombres_fundo`
--
ALTER TABLE `nombres_fundo`
  MODIFY `id_fundo_nombre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `pep`
--
ALTER TABLE `pep`
  MODIFY `id_pep` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `productos_sanidad`
--
ALTER TABLE `productos_sanidad`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT de la tabla `registro_actividad_detalle`
--
ALTER TABLE `registro_actividad_detalle`
  MODIFY `id_RDreporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `registro_actividad_reporte`
--
ALTER TABLE `registro_actividad_reporte`
  MODIFY `id_ARreporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `reporte`
--
ALTER TABLE `reporte`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de la tabla `sub_lote`
--
ALTER TABLE `sub_lote`
  MODIFY `id_sub_lote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
  ADD CONSTRAINT `fundo_ibfk_5` FOREIGN KEY (`lote`) REFERENCES `lote` (`id_lote`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fundo_ibfk_6` FOREIGN KEY (`nombre`) REFERENCES `nombres_fundo` (`id_fundo_nombre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`fk_cultivo`) REFERENCES `cultivo` (`id_cultivo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_2` FOREIGN KEY (`fk_variedad`) REFERENCES `variedad` (`id_variedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_3` FOREIGN KEY (`fk_lote`) REFERENCES `lote` (`id_lote`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_4` FOREIGN KEY (`fk_jefe_fundo`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `reporte_ibfk_5` FOREIGN KEY (`fk_slote`) REFERENCES `sub_lote` (`id_sub_lote`),
  ADD CONSTRAINT `reporte_ibfk_6` FOREIGN KEY (`fk_jefeSanidad`) REFERENCES `usuarios` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_7` FOREIGN KEY (`nom_fundo`) REFERENCES `nombres_fundo` (`id_fundo_nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_8` FOREIGN KEY (`pep`) REFERENCES `pep` (`id_pep`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_9` FOREIGN KEY (`etapa_cultivo`) REFERENCES `etapa_cultivo` (`idEcultivo`) ON DELETE CASCADE ON UPDATE CASCADE;

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
