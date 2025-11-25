-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2025 a las 16:29:09
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
-- Base de datos: `farmacia_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(1, 'Analgesicos'),
(2, 'Antiinflamatorios'),
(3, 'Antibioticos'),
(4, 'Antihistaminicos'),
(5, 'Antigripales'),
(6, 'Gastrointestinales'),
(7, 'Desinfectantes'),
(8, 'Vitaminas'),
(9, 'Control de presion'),
(10, 'Diabetes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `estado` enum('pendiente','aceptada','atendida') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compras`
--

CREATE TABLE `detalle_compras` (
  `id` int(11) NOT NULL,
  `compra_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctor`
--

CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `horario_inicio` time DEFAULT NULL,
  `horario_fin` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `doctor`
--

INSERT INTO `doctor` (`id`, `nombre`, `especialidad`, `horario_inicio`, `horario_fin`) VALUES
(1, 'Dr. Carlos Hernández', 'Medicina General', '09:00:00', '14:00:00'),
(2, 'Dra. Sofía Ramírez', 'Pediatría', '10:00:00', '16:00:00'),
(3, 'Dr. Miguel Torres', 'Medicina Interna', '08:00:00', '13:00:00'),
(4, 'Dra. Laura Méndez', 'Dermatología', '12:00:00', '18:00:00'),
(5, 'Dr. Andrés Guzmán', 'Ginecología', '09:00:00', '15:00:00'),
(6, 'Dra. Valeria Rojas', 'Nutrición', '11:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctor_citas`
--

CREATE TABLE `doctor_citas` (
  `id` int(11) NOT NULL,
  `cita_id` int(11) DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `estado` enum('aceptada','rechazada','atendida') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctor_horario`
--

CREATE TABLE `doctor_horario` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `dia_semana` enum('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo') DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `doctor_horario`
--

INSERT INTO `doctor_horario` (`id`, `doctor_id`, `dia_semana`, `hora_inicio`, `hora_fin`) VALUES
(1, 1, 'Lunes', '09:00:00', '14:00:00'),
(2, 2, 'Lunes', '10:00:00', '16:00:00'),
(3, 3, 'Martes', '08:00:00', '13:00:00'),
(4, 4, 'Martes', '12:00:00', '18:00:00'),
(5, 5, 'Miércoles', '09:00:00', '15:00:00'),
(6, 6, 'Miércoles', '11:00:00', '17:00:00'),
(7, 1, 'Jueves', '09:00:00', '14:00:00'),
(8, 3, 'Jueves', '08:00:00', '13:00:00'),
(9, 2, 'Viernes', '10:00:00', '16:00:00'),
(10, 4, 'Viernes', '12:00:00', '18:00:00'),
(11, 5, 'Sábado', '09:00:00', '14:00:00'),
(12, 6, 'Sábado', '11:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_citas`
--

CREATE TABLE `historial_citas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `estado` enum('pendiente','aceptada','atendida','cancelada') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `categoria`, `precio`, `imagen`, `categoria_id`) VALUES
(61, 'Paracetamol', 'Analgésico y antipirético común', NULL, 25.00, 'paracetamol.jpg', 1),
(62, 'Ibuprofeno', 'Alivia dolor e inflamación', NULL, 30.00, 'ibuprofeno.jpg', 1),
(63, 'Aspirina', 'Alivio de dolor y fiebre', NULL, 28.00, 'aspirina.jpg', 1),
(64, 'Diclofenaco', 'Analgésico antiinflamatorio', NULL, 35.00, 'diclofenaco.jpg', 1),
(65, 'Naproxeno', 'Alivio de dolor e inflamación', NULL, 32.00, 'naproxeno.jpg', 1),
(66, 'Ketorolaco', 'Alivio de dolor intenso', NULL, 40.00, 'ketorolaco.jpg', 1),
(67, 'Ibuprofeno Forte', 'Antiinflamatorio potente', NULL, 38.00, 'ibuprofeno_forte.jpg', 2),
(68, 'Diclofenaco Gel', 'Alivia inflamación localizada', NULL, 45.00, 'diclofenaco_gel.jpg', 2),
(69, 'Naproxeno Retard', 'Antiinflamatorio de liberación prolongada', NULL, 50.00, 'naproxeno_retard.jpg', 2),
(70, 'Meloxicam', 'Alivio de inflamación y dolor articular', NULL, 55.00, 'meloxicam.jpg', 2),
(71, 'Piroxicam', 'Antiinflamatorio potente', NULL, 48.00, 'piroxicam.jpg', 2),
(72, 'Celecoxib', 'Antiinflamatorio selectivo', NULL, 60.00, 'celecoxib.jpg', 2),
(73, 'Amoxicilina', 'Antibiótico de amplio espectro', NULL, 50.00, 'amoxicilina.jpg', 3),
(74, 'Cefalexina', 'Antibiótico para infecciones leves', NULL, 55.00, 'cefalexina.jpg', 3),
(75, 'Azitromicina', 'Antibiótico de uso común', NULL, 70.00, 'azitromicina.jpg', 3),
(76, 'Claritromicina', 'Tratamiento de infecciones respiratorias', NULL, 65.00, 'claritromicina.jpg', 3),
(77, 'Doxiciclina', 'Antibiótico oral', NULL, 60.00, 'doxiciclina.jpg', 3),
(78, 'Levofloxacino', 'Antibiótico potente', NULL, 80.00, 'levofloxacino.jpg', 3),
(79, 'Loratadina', 'Alivia alergias', NULL, 35.00, 'loratadina.jpg', 4),
(80, 'Cetirizina', 'Antihistamínico común', NULL, 38.00, 'cetirizina.jpg', 4),
(81, 'Fexofenadina', 'Alivio de alergias estacionales', NULL, 40.00, 'fexofenadina.jpg', 4),
(82, 'Desloratadina', 'Tratamiento de alergias', NULL, 45.00, 'desloratadina.jpg', 4),
(83, 'Clorfenamina', 'Antihistamínico de acción rápida', NULL, 30.00, 'clorfenamina.jpg', 4),
(84, 'Levocetirizina', 'Alivio de síntomas de alergia', NULL, 42.00, 'levocetirizina.jpg', 4),
(85, 'Paracetamol Antigripal', 'Alivio de síntomas gripales', NULL, 28.00, 'paracetamol_antigripal.jpg', 5),
(86, 'Ibuprofeno Antigripal', 'Alivio de fiebre y dolor', NULL, 32.00, 'ibuprofeno_antigripal.jpg', 5),
(87, 'Vick VapoRub', 'Descongestiona vías respiratorias', NULL, 35.00, 'vick_vaporub.jpg', 5),
(88, 'Frenadol', 'Alivio de gripe y resfriado', NULL, 40.00, 'frenadol.jpg', 5),
(89, 'Grippostad', 'Alivio rápido de síntomas', NULL, 42.00, 'grippostad.jpg', 5),
(90, 'Antigripal Forte', 'Alivio intenso de gripe', NULL, 45.00, 'antigripal_forte.jpg', 5),
(91, 'Omeprazol', 'Protege estómago y reduce acidez', NULL, 50.00, 'omeprazol.jpg', 6),
(92, 'Loperamida', 'Control de diarrea', NULL, 30.00, 'loperamida.jpg', 6),
(93, 'Almagato', 'Antiácido y protección gástrica', NULL, 28.00, 'almagato.jpg', 6),
(94, 'Simeticona', 'Alivio de gases', NULL, 25.00, 'simeticona.jpg', 6),
(95, 'Ranitidina', 'Reduce acidez y reflujo', NULL, 40.00, 'ranitidina.jpg', 6),
(96, 'Metoclopramida', 'Mejora digestión y náusea', NULL, 35.00, 'metoclopramida.jpg', 6),
(97, 'Alcohol Gel', 'Desinfección de manos', NULL, 20.00, 'alcohol_gel.jpg', 7),
(98, 'Clorhexidina', 'Desinfectante de heridas', NULL, 35.00, 'clorhexidina.jpg', 7),
(99, 'Alcohol 70%', 'Uso general de limpieza', NULL, 18.00, 'alcohol_70.jpg', 7),
(100, 'Jabón Antibacterial', 'Limpieza de piel', NULL, 22.00, 'jabon_antibacterial.jpg', 7),
(101, 'Solución yodada', 'Desinfección de heridas', NULL, 25.00, 'solucion_yodada.jpg', 7),
(102, 'Spray Desinfectante', 'Superficies y manos', NULL, 30.00, 'spray_desinfectante.jpg', 7),
(103, 'Vitamina C', 'Refuerza sistema inmune', NULL, 40.00, 'vitamina_c.jpg', 8),
(104, 'Vitamina D', 'Salud ósea', NULL, 45.00, 'vitamina_d.jpg', 8),
(105, 'Vitamina B12', 'Energía y metabolismo', NULL, 50.00, 'vitamina_b12.jpg', 8),
(106, 'Multivitamínico', 'Vitaminas esenciales', NULL, 60.00, 'multivitaminico.jpg', 8),
(107, 'Vitamina E', 'Antioxidante', NULL, 55.00, 'vitamina_e.jpg', 8),
(108, 'Vitamina A', 'Salud ocular', NULL, 48.00, 'vitamina_a.jpg', 8),
(109, 'Enalapril', 'Control de hipertensión', NULL, 60.00, 'enalapril.jpg', 9),
(110, 'Losartán', 'Regula presión arterial', NULL, 65.00, 'losartan.jpg', 9),
(111, 'Amlodipino', 'Tratamiento de hipertensión', NULL, 70.00, 'amlodipino.jpg', 9),
(112, 'Captopril', 'Control de presión rápida', NULL, 55.00, 'captopril.jpg', 9),
(113, 'Hidroclorotiazida', 'Diurético para presión', NULL, 50.00, 'hidroclorotiazida.jpg', 9),
(114, 'Valsartán', 'Tratamiento de hipertensión', NULL, 68.00, 'valsartan.jpg', 9),
(115, 'Metformina', 'Control de glucosa', NULL, 60.00, 'metformina.jpg', 10),
(116, 'Insulina NPH', 'Regulación de insulina', NULL, 120.00, 'insulina_nph.jpg', 10),
(117, 'Glipizida', 'Medicamento oral para diabetes', NULL, 70.00, 'glipizida.jpg', 10),
(118, 'Gliclazida', 'Control de glucosa en sangre', NULL, 75.00, 'gliclazida.jpg', 10),
(119, 'Pioglitazona', 'Tratamiento de diabetes tipo 2', NULL, 80.00, 'pioglitazona.jpg', 10),
(120, 'Sitagliptina', 'Control de azúcar en sangre', NULL, 90.00, 'sitagliptina.jpg', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `telefono`, `password`) VALUES
(1, 'johan', 'johan@gmail.com', '9988102735', '1234'),
(2, 'JOHAN GABRIEL', 'johangabriel@gmail.com', '9988102736', '12345');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `compra_id` (`compra_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `doctor_citas`
--
ALTER TABLE `doctor_citas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cita_id` (`cita_id`);

--
-- Indices de la tabla `doctor_horario`
--
ALTER TABLE `doctor_horario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indices de la tabla `historial_citas`
--
ALTER TABLE `historial_citas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_categoria` (`categoria_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `doctor_citas`
--
ALTER TABLE `doctor_citas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `doctor_horario`
--
ALTER TABLE `doctor_horario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `historial_citas`
--
ALTER TABLE `historial_citas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `detalle_compras`
--
ALTER TABLE `detalle_compras`
  ADD CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`),
  ADD CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `doctor_citas`
--
ALTER TABLE `doctor_citas`
  ADD CONSTRAINT `doctor_citas_ibfk_1` FOREIGN KEY (`cita_id`) REFERENCES `citas` (`id`);

--
-- Filtros para la tabla `doctor_horario`
--
ALTER TABLE `doctor_horario`
  ADD CONSTRAINT `doctor_horario_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`);

--
-- Filtros para la tabla `historial_citas`
--
ALTER TABLE `historial_citas`
  ADD CONSTRAINT `historial_citas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
