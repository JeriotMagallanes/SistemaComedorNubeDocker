-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-01-2024 a las 04:51:27
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
(10, '2024-01-20 07:51:35', 'Mañana', 'c', 'c', 'c', 29, 'ALPINE 511', 53, 114, 10, 21, 'Aprobado', 'No Aprobado'),
(13, '2024-01-23 06:30:51', 'Mañana', 'rrr', 'rrrr', 'rr', 28, 'SANTA INES', 44, 104, 6, 20, 'Aprobado', 'Aprobado'),
(14, '2024-01-23 06:30:51', 'Mañana', 'y', 'y', 'y', 27, 'DOS MARIAS', 42, 101, 6, 19, 'Aprobado', 'No Aprobado'),
(16, '2024-01-23 22:33:42', 'Noche', 'b', 'b', 'b', 26, 'DOS MARIAS', 41, 100, 6, 19, 'Aprobado', 'No Aprobado'),
(17, '2024-01-23 22:36:21', 'Noche', 'r', 'r', 'r', 24, 'SANTA LUCIA', 37, 93, 4, 18, 'Aprobado', 'No Aprobado');

--
-- Índices para tablas volcadas
--

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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `reporte`
--
ALTER TABLE `reporte`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`fk_cultivo`) REFERENCES `cultivo` (`id_cultivo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_2` FOREIGN KEY (`fk_variedad`) REFERENCES `variedad` (`id_variedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_3` FOREIGN KEY (`fk_lote`) REFERENCES `lote` (`id_lote`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reporte_ibfk_4` FOREIGN KEY (`fk_jefe_fundo`) REFERENCES `usuarios` (`idusuario`),
  ADD CONSTRAINT `reporte_ibfk_5` FOREIGN KEY (`fk_slote`) REFERENCES `sub_lote` (`id_sub_lote`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
