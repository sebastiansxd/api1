-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-02-2026 a las 03:49:37
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
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"empresa_envios\",\"table\":\"ruta\"},{\"db\":\"empresa_envios\",\"table\":\"paquete\"},{\"db\":\"empresa_envios\",\"table\":\"compra\"},{\"db\":\"empresa_envios\",\"table\":\"cliente\"},{\"db\":\"empresa_envios\",\"table\":\"orden_envio\"},{\"db\":\"empresa_envios\",\"table\":\"entrega\"},{\"db\":\"empresa_envios\",\"table\":\"empleado\"},{\"db\":\"empresa_envios\",\"table\":\"compra_producto\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-11-14 21:09:02', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\",\"NavigationWidth\":344}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `railway`
--
CREATE DATABASE IF NOT EXISTS `railway` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `railway`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `action` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `record_id` varchar(200) DEFAULT NULL,
  `old_data` text DEFAULT NULL,
  `new_data` text DEFAULT NULL,
  `created_by` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedidos`
--

CREATE TABLE `detalle_pedidos` (
  `id_detalle` int(11) NOT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) DEFAULT NULL,
  `id_repartidor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_product` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `id_restaurante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repartidores`
--

CREATE TABLE `repartidores` (
  `id_repartidor` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `vehiculo` varchar(50) DEFAULT NULL,
  `estado` enum('disponible','ocupado') DEFAULT 'disponible'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restaurantes`
--

CREATE TABLE `restaurantes` (
  `id_restaurante` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_repartidor` (`id_repartidor`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_product`),
  ADD KEY `id_restaurante` (`id_restaurante`);

--
-- Indices de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  ADD PRIMARY KEY (`id_repartidor`);

--
-- Indices de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  ADD PRIMARY KEY (`id_restaurante`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  MODIFY `id_repartidor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  MODIFY `id_restaurante` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD CONSTRAINT `detalle_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_product`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_repartidor`) REFERENCES `repartidores` (`id_repartidor`) ON DELETE SET NULL;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurantes` (`id_restaurante`) ON DELETE SET NULL;
--
-- Base de datos: `sena_registro`
--
CREATE DATABASE IF NOT EXISTS `sena_registro` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `sena_registro`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigos_guardia`
--

CREATE TABLE `codigos_guardia` (
  `id` int(11) NOT NULL,
  `guardia_id` int(11) NOT NULL,
  `codigo_acceso` varchar(100) NOT NULL,
  `ubicacion_asignada` int(11) NOT NULL,
  `turno` varchar(100) NOT NULL,
  `fecha_asignacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `serial` varchar(200) NOT NULL,
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL DEFAULT 'dispositivo',
  `foto_url` varchar(500) NOT NULL,
  `caracteristicas` text NOT NULL,
  `codigo_qr` varchar(300) NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `verified_by` int(11) DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `estado_dispositivo` enum('activo','inactivo','desactivado','perdido') NOT NULL DEFAULT 'activo',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_expiracion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `devices`
--

INSERT INTO `devices` (`id`, `owner_id`, `serial`, `marca`, `modelo`, `tipo`, `foto_url`, `caracteristicas`, `codigo_qr`, `is_verified`, `verified_by`, `verified_at`, `estado_dispositivo`, `fecha_registro`, `fecha_actualizacion`, `fecha_expiracion`) VALUES
(5, 4, '2222', '222', '22', 'dispositivo', 'no_image.jpg', '222', '7101b2e09deadcc8', 1, 4, '2025-12-11 08:46:31', 'activo', '2025-12-11 08:40:35', '2025-12-11 08:46:31', NULL),
(6, 4, '1sw', 'qqq', 'qq', 'dispositivo', 'no_image.jpg', 'qq', '2dbf33eb9889dd74', 1, 4, '2025-12-11 15:24:10', 'activo', '2025-12-11 15:23:52', '2025-12-11 15:24:10', NULL),
(7, 4, '1w', '2', '2', 'dispositivo', '2', '2', '334a3b067000eec8', 0, NULL, NULL, 'activo', '2025-12-12 18:04:41', '2025-12-12 18:04:41', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `device_verifications`
--

CREATE TABLE `device_verifications` (
  `id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `guardia_id` int(11) NOT NULL,
  `verified_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `observaciones` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `device_verifications`
--

INSERT INTO `device_verifications` (`id`, `device_id`, `guardia_id`, `verified_at`, `observaciones`) VALUES
(3, 5, 4, '2025-12-11 08:46:31', 'w'),
(4, 6, 4, '2025-12-11 15:24:10', 's');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada_salida_logs`
--

CREATE TABLE `entrada_salida_logs` (
  `id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `guardia_id` int(11) NOT NULL,
  `ubicacion_id` int(11) NOT NULL,
  `tipo_evento` enum('entrada','salida') NOT NULL,
  `metodo` enum('qr','manual') NOT NULL,
  `resultado` enum('autorizado','rechazado','error') NOT NULL,
  `timestamp_evento` timestamp NOT NULL DEFAULT current_timestamp(),
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_logins`
--

CREATE TABLE `failed_logins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `intento_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_agent` varchar(255) NOT NULL,
  `ip` varchar(100) NOT NULL,
  `dispositivo_tag` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidentes`
--

CREATE TABLE `incidentes` (
  `id` int(11) NOT NULL,
  `dispositivo_id` int(11) NOT NULL,
  `tipo_incidente` enum('qr_duplicado','salida_sin_entrada','no_autorizado','otro') NOT NULL,
  `descripcion` text NOT NULL,
  `estado` enum('abierto','cerrado') NOT NULL DEFAULT 'abierto',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `destinatario_id` int(11) NOT NULL,
  `tipo_evento` varchar(100) NOT NULL,
  `asunto` varchar(200) NOT NULL,
  `mensaje` text NOT NULL,
  `estado` enum('pendiente','enviado','fallido') NOT NULL DEFAULT 'pendiente',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_envio` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubications`
--

CREATE TABLE `ubications` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ubications`
--

INSERT INTO `ubications` (`id`, `nombre`, `descripcion`) VALUES
(1, 'entrada_aprendices', 'Puerta principal para aprendices'),
(2, 'entrada_vehiculos', 'Zona de entrada y salida de vehículos'),
(3, 'entrada_instructores', 'Acceso exclusivo para instructores');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `rol` enum('admin','aprendiz','guardia') NOT NULL,
  `correo_sena` varchar(200) NOT NULL,
  `correo_personal` varchar(200) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `tipo_identidad` varchar(50) NOT NULL,
  `numero_identidad` varchar(50) NOT NULL,
  `foto_carnet_url` varchar(500) NOT NULL,
  `estado` enum('activo','bloqueado') NOT NULL DEFAULT 'activo',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `rol`, `correo_sena`, `correo_personal`, `password_hash`, `nombre`, `apellido`, `telefono`, `fecha_nacimiento`, `tipo_identidad`, `numero_identidad`, `foto_carnet_url`, `estado`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(4, 'admin', 'admin@sena.edu', 'admin@example.com', '$2y$10$UYLtzS5rJ2cV8ueNHQ9yKe6LiGjRXGfpuf5rnU28/y99lUuFvtgGu', 'Admin', 'User', '', '0000-00-00', '', '', '', 'activo', '2025-12-11 08:27:59', '2025-12-11 08:27:59');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `codigos_guardia`
--
ALTER TABLE `codigos_guardia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_acceso` (`codigo_acceso`),
  ADD KEY `fk_guardia_code` (`guardia_id`),
  ADD KEY `fk_guardia_ubic` (`ubicacion_asignada`);

--
-- Indices de la tabla `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_qr` (`codigo_qr`),
  ADD KEY `fk_device_owner` (`owner_id`),
  ADD KEY `fk_device_verified_by` (`verified_by`);

--
-- Indices de la tabla `device_verifications`
--
ALTER TABLE `device_verifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_verification_device` (`device_id`),
  ADD KEY `fk_verification_guardia` (`guardia_id`);

--
-- Indices de la tabla `entrada_salida_logs`
--
ALTER TABLE `entrada_salida_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_log_device` (`device_id`),
  ADD KEY `fk_log_guardia` (`guardia_id`),
  ADD KEY `fk_log_ubicacion` (`ubicacion_id`);

--
-- Indices de la tabla `failed_logins`
--
ALTER TABLE `failed_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_failed_user` (`user_id`);

--
-- Indices de la tabla `incidentes`
--
ALTER TABLE `incidentes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_incidente_device` (`dispositivo_id`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_notif_user` (`destinatario_id`);

--
-- Indices de la tabla `ubications`
--
ALTER TABLE `ubications`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo_sena` (`correo_sena`),
  ADD UNIQUE KEY `numero_identidad` (`numero_identidad`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `codigos_guardia`
--
ALTER TABLE `codigos_guardia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `device_verifications`
--
ALTER TABLE `device_verifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `entrada_salida_logs`
--
ALTER TABLE `entrada_salida_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `failed_logins`
--
ALTER TABLE `failed_logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `incidentes`
--
ALTER TABLE `incidentes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ubications`
--
ALTER TABLE `ubications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `codigos_guardia`
--
ALTER TABLE `codigos_guardia`
  ADD CONSTRAINT `fk_guardia_code` FOREIGN KEY (`guardia_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_guardia_ubic` FOREIGN KEY (`ubicacion_asignada`) REFERENCES `ubications` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `devices`
--
ALTER TABLE `devices`
  ADD CONSTRAINT `fk_device_owner` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_device_verified_by` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `device_verifications`
--
ALTER TABLE `device_verifications`
  ADD CONSTRAINT `fk_verification_device` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_verification_guardia` FOREIGN KEY (`guardia_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `entrada_salida_logs`
--
ALTER TABLE `entrada_salida_logs`
  ADD CONSTRAINT `fk_log_device` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_log_guardia` FOREIGN KEY (`guardia_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_log_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubications` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `failed_logins`
--
ALTER TABLE `failed_logins`
  ADD CONSTRAINT `fk_failed_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `incidentes`
--
ALTER TABLE `incidentes`
  ADD CONSTRAINT `fk_incidente_device` FOREIGN KEY (`dispositivo_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notif_user` FOREIGN KEY (`destinatario_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Base de datos: `sistema_citas`
--
CREATE DATABASE IF NOT EXISTS `sistema_citas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sistema_citas`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_consultorio`
--

CREATE TABLE `asignacion_consultorio` (
  `asignacion_id` int(11) NOT NULL,
  `medico_id` int(11) NOT NULL,
  `consultorio_id` int(11) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `nota` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `cita_id` int(11) NOT NULL,
  `paciente_id` int(11) NOT NULL,
  `medico_id` int(11) NOT NULL,
  `consultorio_id` int(11) DEFAULT NULL,
  `tipo_cita_id` int(11) NOT NULL,
  `creada_por` int(11) NOT NULL,
  `fecha_hora_inicio` datetime NOT NULL,
  `fecha_hora_fin` datetime NOT NULL,
  `estado` enum('PROGRAMADA','CANCELADA','ATENDIDA','REPROGRAMADA') DEFAULT 'PROGRAMADA',
  `motivo` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultorio`
--

CREATE TABLE `consultorio` (
  `consultorio_id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `piso` varchar(30) DEFAULT NULL,
  `sede_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `consultorio`
--

INSERT INTO `consultorio` (`consultorio_id`, `codigo`, `descripcion`, `piso`, `sede_id`) VALUES
(1, '1w', '111111111', '1111111111', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibilidad`
--

CREATE TABLE `disponibilidad` (
  `disponibilidad_id` int(11) NOT NULL,
  `medico_id` int(11) NOT NULL,
  `sede_id` int(11) NOT NULL,
  `tipo_disponibilidad` enum('SEMANAL','RANGO') NOT NULL,
  `dia_semana` tinyint(4) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `nota` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `especialidad_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`especialidad_id`, `nombre`, `descripcion`) VALUES
(1, 'wwdw', 'ccdad'),
(2, 'qq', 'qq');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico`
--

CREATE TABLE `medico` (
  `medico_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `documento` varchar(50) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `licencia_profesional` varchar(100) NOT NULL,
  `observaciones` text DEFAULT NULL,
  `especialidad_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`medico_id`, `nombre`, `apellido`, `documento`, `telefono`, `email`, `licencia_profesional`, `observaciones`, `especialidad_id`) VALUES
(1, 'w', 'w', 'w', 'ww', 'w', 'w', 'wwwwwwww', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `paciente_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `documento` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `sexo` enum('M','F','O') DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `antecedentes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sede`
--

CREATE TABLE `sede` (
  `sede_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sede`
--

INSERT INTO `sede` (`sede_id`, `nombre`, `direccion`, `telefono`, `ciudad`) VALUES
(1, '111w', '1111111111', '11111111111', '111111111111');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_cita`
--

CREATE TABLE `tipo_cita` (
  `tipo_cita_id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `duracion_estandar_minutos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `rol` enum('ADMIN','RECEPCION','OTRO') NOT NULL,
  `password_hash` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignacion_consultorio`
--
ALTER TABLE `asignacion_consultorio`
  ADD PRIMARY KEY (`asignacion_id`),
  ADD KEY `medico_id` (`medico_id`),
  ADD KEY `consultorio_id` (`consultorio_id`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`cita_id`),
  ADD KEY `paciente_id` (`paciente_id`),
  ADD KEY `medico_id` (`medico_id`),
  ADD KEY `consultorio_id` (`consultorio_id`),
  ADD KEY `tipo_cita_id` (`tipo_cita_id`),
  ADD KEY `creada_por` (`creada_por`);

--
-- Indices de la tabla `consultorio`
--
ALTER TABLE `consultorio`
  ADD PRIMARY KEY (`consultorio_id`),
  ADD UNIQUE KEY `sede_id` (`sede_id`,`codigo`);

--
-- Indices de la tabla `disponibilidad`
--
ALTER TABLE `disponibilidad`
  ADD PRIMARY KEY (`disponibilidad_id`),
  ADD KEY `medico_id` (`medico_id`),
  ADD KEY `sede_id` (`sede_id`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`especialidad_id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`medico_id`),
  ADD UNIQUE KEY `documento` (`documento`),
  ADD UNIQUE KEY `licencia_profesional` (`licencia_profesional`),
  ADD KEY `especialidad_id` (`especialidad_id`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`paciente_id`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- Indices de la tabla `sede`
--
ALTER TABLE `sede`
  ADD PRIMARY KEY (`sede_id`);

--
-- Indices de la tabla `tipo_cita`
--
ALTER TABLE `tipo_cita`
  ADD PRIMARY KEY (`tipo_cita_id`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignacion_consultorio`
--
ALTER TABLE `asignacion_consultorio`
  MODIFY `asignacion_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `cita_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `consultorio`
--
ALTER TABLE `consultorio`
  MODIFY `consultorio_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `disponibilidad`
--
ALTER TABLE `disponibilidad`
  MODIFY `disponibilidad_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `especialidad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `medico`
--
ALTER TABLE `medico`
  MODIFY `medico_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `paciente_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sede`
--
ALTER TABLE `sede`
  MODIFY `sede_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipo_cita`
--
ALTER TABLE `tipo_cita`
  MODIFY `tipo_cita_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacion_consultorio`
--
ALTER TABLE `asignacion_consultorio`
  ADD CONSTRAINT `asignacion_consultorio_ibfk_1` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`medico_id`),
  ADD CONSTRAINT `asignacion_consultorio_ibfk_2` FOREIGN KEY (`consultorio_id`) REFERENCES `consultorio` (`consultorio_id`);

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `paciente` (`paciente_id`),
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`medico_id`),
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`consultorio_id`) REFERENCES `consultorio` (`consultorio_id`),
  ADD CONSTRAINT `cita_ibfk_4` FOREIGN KEY (`tipo_cita_id`) REFERENCES `tipo_cita` (`tipo_cita_id`),
  ADD CONSTRAINT `cita_ibfk_5` FOREIGN KEY (`creada_por`) REFERENCES `usuario` (`usuario_id`);

--
-- Filtros para la tabla `consultorio`
--
ALTER TABLE `consultorio`
  ADD CONSTRAINT `consultorio_ibfk_1` FOREIGN KEY (`sede_id`) REFERENCES `sede` (`sede_id`);

--
-- Filtros para la tabla `disponibilidad`
--
ALTER TABLE `disponibilidad`
  ADD CONSTRAINT `disponibilidad_ibfk_1` FOREIGN KEY (`medico_id`) REFERENCES `medico` (`medico_id`),
  ADD CONSTRAINT `disponibilidad_ibfk_2` FOREIGN KEY (`sede_id`) REFERENCES `sede` (`sede_id`);

--
-- Filtros para la tabla `medico`
--
ALTER TABLE `medico`
  ADD CONSTRAINT `medico_ibfk_1` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`especialidad_id`);
--
-- Base de datos: `sistema_domicilios`
--
CREATE DATABASE IF NOT EXISTS `sistema_domicilios` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `sistema_domicilios`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedidos`
--

CREATE TABLE `detalle_pedidos` (
  `id_detalle` int(11) NOT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_pedidos`
--

INSERT INTO `detalle_pedidos` (`id_detalle`, `id_pedido`, `id_producto`, `cantidad`) VALUES
(1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) DEFAULT NULL,
  `id_repartidor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `fecha`, `total`, `id_repartidor`) VALUES
(1, '2026-02-17 23:08:24', 55000.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_product` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `id_restaurante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_product`, `nombre`, `precio`, `id_restaurante`) VALUES
(1, 'Pizza Margarita', 25000.00, 1),
(2, 'Pizza Pepperoni', 30000.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repartidores`
--

CREATE TABLE `repartidores` (
  `id_repartidor` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `vehiculo` varchar(50) DEFAULT NULL,
  `estado` enum('disponible','ocupado') DEFAULT 'disponible'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `repartidores`
--

INSERT INTO `repartidores` (`id_repartidor`, `nombre`, `vehiculo`, `estado`) VALUES
(1, 'Juan Perez', 'Moto', 'disponible'),
(2, 'Ana Gomez', 'Bicicleta', 'disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restaurantes`
--

CREATE TABLE `restaurantes` (
  `id_restaurante` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `restaurantes`
--

INSERT INTO `restaurantes` (`id_restaurante`, `nombre`, `direccion`, `categoria`) VALUES
(1, 'Pizzeria Uno', 'Calle Principal 1', 'Italiana'),
(2, 'Sushi Place', 'Avenida Central 5', 'Asiática');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_repartidor` (`id_repartidor`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_product`),
  ADD KEY `id_restaurante` (`id_restaurante`);

--
-- Indices de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  ADD PRIMARY KEY (`id_repartidor`);

--
-- Indices de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  ADD PRIMARY KEY (`id_restaurante`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  MODIFY `id_repartidor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  MODIFY `id_restaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD CONSTRAINT `detalle_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  ADD CONSTRAINT `detalle_pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_product`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_repartidor`) REFERENCES `repartidores` (`id_repartidor`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurantes` (`id_restaurante`);
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
