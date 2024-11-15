-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-08-2024 a las 16:24:51
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
-- Base de datos: `sistemacomedor`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistenciacomedoralmuerzo`
--

CREATE TABLE `asistenciacomedoralmuerzo` (
  `id_Asistencia` int(11) NOT NULL,
  `fechaHora` datetime NOT NULL,
  `dni` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asistenciacomedoralmuerzo`
--

INSERT INTO `asistenciacomedoralmuerzo` (`id_Asistencia`, `fechaHora`, `dni`) VALUES
(1, '2024-08-20 23:50:47', '77696776'),
(2, '2024-08-20 23:51:01', '2'),
(3, '2024-08-20 23:52:08', '3'),
(4, '2024-08-20 23:52:08', '4'),
(5, '2024-08-20 23:52:08', '5'),
(6, '2024-08-20 23:52:08', '6'),
(7, '2024-08-20 23:52:08', '7'),
(8, '2024-08-20 23:52:08', '8'),
(9, '2024-08-20 23:52:08', '9'),
(10, '2024-08-20 23:52:08', '10'),
(11, '2024-08-20 23:52:08', '11'),
(12, '2024-08-20 23:52:08', '12'),
(13, '2024-08-20 23:52:08', '13'),
(14, '2024-08-20 23:52:08', '14'),
(15, '2024-08-20 23:52:08', '15'),
(16, '2024-08-20 23:52:08', '16'),
(17, '2024-08-20 23:52:08', '17'),
(18, '2024-08-20 23:52:08', '18'),
(19, '2024-08-20 23:52:08', '19'),
(20, '2024-08-20 23:52:08', '20'),
(21, '2024-08-20 23:52:08', '25'),
(22, '2024-08-20 23:52:08', '24'),
(23, '2024-08-20 23:52:08', '23'),
(24, '2024-08-20 23:52:08', '22'),
(25, '2024-08-20 23:52:08', '21');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistenciacomedoralmuerzo`
--
ALTER TABLE `asistenciacomedoralmuerzo`
  ADD PRIMARY KEY (`id_Asistencia`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistenciacomedoralmuerzo`
--
ALTER TABLE `asistenciacomedoralmuerzo`
  MODIFY `id_Asistencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
