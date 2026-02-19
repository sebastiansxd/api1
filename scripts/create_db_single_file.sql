-- Archivo: scripts/create_db_single_file.sql
-- Uso: ejecutar con el cliente mysql o pegar en DBeaver (conexión a la BD meta)
-- Ejemplo CLI:
--   mysql -h <DB_HOST> -P <DB_PORT> -u <DB_USER> -p -e "SOURCE scripts/create_db_single_file.sql"

-- Elimina la base existente (opcional)
DROP DATABASE IF EXISTS `railway`;

-- Crea la base y las tablas mínimas necesarias para la API
CREATE DATABASE IF NOT EXISTS `railway` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `railway`;

-- Restaurantes
CREATE TABLE IF NOT EXISTS `restaurantes` (
  `id_restaurante` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) DEFAULT NULL,
  `direccion` VARCHAR(150) DEFAULT NULL,
  `categoria` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id_restaurante`)
);

-- Repartidores
CREATE TABLE IF NOT EXISTS `repartidores` (
  `id_repartidor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) DEFAULT NULL,
  `vehiculo` VARCHAR(50) DEFAULT NULL,
  `estado` ENUM('disponible','ocupado') DEFAULT 'disponible',
  PRIMARY KEY (`id_repartidor`)
);

-- Productos
CREATE TABLE IF NOT EXISTS `productos` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) DEFAULT NULL,
  `precio` DECIMAL(10,2) DEFAULT NULL,
  `id_restaurante` INT DEFAULT NULL,
  PRIMARY KEY (`id_product`),
  KEY `id_restaurante` (`id_restaurante`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurantes` (`id_restaurante`) ON DELETE SET NULL
);

-- Pedidos
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `total` DECIMAL(10,2) DEFAULT NULL,
  `id_repartidor` INT DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_repartidor` (`id_repartidor`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_repartidor`) REFERENCES `repartidores` (`id_repartidor`) ON DELETE SET NULL
);

-- Detalle de pedidos
CREATE TABLE IF NOT EXISTS `detalle_pedidos` (
  `id_detalle` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT DEFAULT NULL,
  `id_producto` INT DEFAULT NULL,
  `cantidad` INT DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE,
  CONSTRAINT `detalle_pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_product`) ON DELETE RESTRICT
);

-- Tabla de auditoría simple
CREATE TABLE IF NOT EXISTS `audit_logs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `table_name` VARCHAR(100) NOT NULL,
  `action` ENUM('INSERT','UPDATE','DELETE') NOT NULL,
  `record_id` VARCHAR(200),
  `old_data` TEXT,
  `new_data` TEXT,
  `created_by` VARCHAR(200),
  `created_at` DATETIME,
  PRIMARY KEY (`id`)
);

-- Fin del script
