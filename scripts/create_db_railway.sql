-- Script para crear tablas y auditoría en la base de datos `railway`
-- Ejecuta esto en DBeaver con la conexión a la BD `railway` seleccionada

USE `railway`;

-- Drop en orden inverso para permitir re-ejecución
DROP TRIGGER IF EXISTS trg_restaurantes_ai;
DROP TRIGGER IF EXISTS trg_restaurantes_au;
DROP TRIGGER IF EXISTS trg_restaurantes_ad;
DROP TRIGGER IF EXISTS trg_repartidores_ai;
DROP TRIGGER IF EXISTS trg_repartidores_au;
DROP TRIGGER IF EXISTS trg_repartidores_ad;
DROP TRIGGER IF EXISTS trg_productos_ai;
DROP TRIGGER IF EXISTS trg_productos_au;
DROP TRIGGER IF EXISTS trg_productos_ad;
DROP TRIGGER IF EXISTS trg_pedidos_ai;
DROP TRIGGER IF EXISTS trg_pedidos_au;
DROP TRIGGER IF EXISTS trg_pedidos_ad;
DROP TRIGGER IF EXISTS trg_detalle_pedidos_ai;
DROP TRIGGER IF EXISTS trg_detalle_pedidos_au;
DROP TRIGGER IF EXISTS trg_detalle_pedidos_ad;
DROP TRIGGER IF EXISTS trg_audit_set_created_at;

DROP TABLE IF EXISTS `detalle_pedidos`;
DROP TABLE IF EXISTS `pedidos`;
DROP TABLE IF EXISTS `productos`;
DROP TABLE IF EXISTS `repartidores`;
DROP TABLE IF EXISTS `restaurantes`;
DROP TABLE IF EXISTS `audit_logs`;

-- Restaurantes
CREATE TABLE `restaurantes` (
  `id_restaurante` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) DEFAULT NULL,
  `direccion` VARCHAR(150) DEFAULT NULL,
  `categoria` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id_restaurante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Repartidores
CREATE TABLE `repartidores` (
  `id_repartidor` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) DEFAULT NULL,
  `vehiculo` VARCHAR(50) DEFAULT NULL,
  `estado` ENUM('disponible','ocupado') DEFAULT 'disponible',
  PRIMARY KEY (`id_repartidor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Productos (depende de restaurantes)
CREATE TABLE `productos` (
  `id_product` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) DEFAULT NULL,
  `precio` DECIMAL(10,2) DEFAULT NULL,
  `id_restaurante` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id_product`),
  KEY `id_restaurante` (`id_restaurante`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurantes` (`id_restaurante`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Pedidos (depende de repartidores)
CREATE TABLE `pedidos` (
  `id_pedido` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME DEFAULT current_timestamp(),
  `total` DECIMAL(10,2) DEFAULT NULL,
  `id_repartidor` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_repartidor` (`id_repartidor`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_repartidor`) REFERENCES `repartidores` (`id_repartidor`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Detalle de pedidos (depende de pedidos y productos)
CREATE TABLE `detalle_pedidos` (
  `id_detalle` INT(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` INT(11) DEFAULT NULL,
  `id_producto` INT(11) DEFAULT NULL,
  `cantidad` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_product`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla de auditoría (compatible con versiones antiguas)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Trigger para rellenar created_at si es NULL (compatibilidad)
DELIMITER $$
CREATE TRIGGER trg_audit_set_created_at
BEFORE INSERT ON audit_logs
FOR EACH ROW
BEGIN
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = NOW();
  END IF;
END$$

-- Triggers de auditoría (construyen JSON en TEXT para máxima compatibilidad)

-- Restaurantes
CREATE TRIGGER trg_restaurantes_ai AFTER INSERT ON `restaurantes`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, new_data, created_by)
  VALUES(
    'restaurantes','INSERT', CAST(NEW.id_restaurante AS CHAR),
    CONCAT('{"id_restaurante":',IFNULL(NEW.id_restaurante,'null'),
           ',"nombre":',QUOTE(NEW.nombre),
           ',"direccion":',QUOTE(NEW.direccion),
           ',"categoria":',QUOTE(NEW.categoria),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_restaurantes_au AFTER UPDATE ON `restaurantes`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, new_data, created_by)
  VALUES(
    'restaurantes','UPDATE', CAST(NEW.id_restaurante AS CHAR),
    CONCAT('{"id_restaurante":',IFNULL(OLD.id_restaurante,'null'),',"nombre":',QUOTE(OLD.nombre),',"direccion":',QUOTE(OLD.direccion),',"categoria":',QUOTE(OLD.categoria),'}'),
    CONCAT('{"id_restaurante":',IFNULL(NEW.id_restaurante,'null'),',"nombre":',QUOTE(NEW.nombre),',"direccion":',QUOTE(NEW.direccion),',"categoria":',QUOTE(NEW.categoria),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_restaurantes_ad AFTER DELETE ON `restaurantes`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'restaurantes','DELETE', CAST(OLD.id_restaurante AS CHAR),
    CONCAT('{"id_restaurante":',IFNULL(OLD.id_restaurante,'null'),',"nombre":',QUOTE(OLD.nombre),',"direccion":',QUOTE(OLD.direccion),',"categoria":',QUOTE(OLD.categoria),'}'),
    CURRENT_USER()
  );
END$$

-- Repartidores
CREATE TRIGGER trg_repartidores_ai AFTER INSERT ON `repartidores`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, new_data, created_by)
  VALUES(
    'repartidores','INSERT', CAST(NEW.id_repartidor AS CHAR),
    CONCAT('{"id_repartidor":',IFNULL(NEW.id_repartidor,'null'),',"nombre":',QUOTE(NEW.nombre),',"vehiculo":',QUOTE(NEW.vehiculo),',"estado":',QUOTE(NEW.estado),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_repartidores_au AFTER UPDATE ON `repartidores`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, new_data, created_by)
  VALUES(
    'repartidores','UPDATE', CAST(NEW.id_repartidor AS CHAR),
    CONCAT('{"id_repartidor":',IFNULL(OLD.id_repartidor,'null'),',"nombre":',QUOTE(OLD.nombre),',"vehiculo":',QUOTE(OLD.vehiculo),',"estado":',QUOTE(OLD.estado),'}'),
    CONCAT('{"id_repartidor":',IFNULL(NEW.id_repartidor,'null'),',"nombre":',QUOTE(NEW.nombre),',"vehiculo":',QUOTE(NEW.vehiculo),',"estado":',QUOTE(NEW.estado),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_repartidores_ad AFTER DELETE ON `repartidores`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'repartidores','DELETE', CAST(OLD.id_repartidor AS CHAR),
    CONCAT('{"id_repartidor":',IFNULL(OLD.id_repartidor,'null'),',"nombre":',QUOTE(OLD.nombre),',"vehiculo":',QUOTE(OLD.vehiculo),',"estado":',QUOTE(OLD.estado),'}'),
    CURRENT_USER()
  );
END$$

-- Productos
CREATE TRIGGER trg_productos_ai AFTER INSERT ON `productos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, new_data, created_by)
  VALUES(
    'productos','INSERT', CAST(NEW.id_product AS CHAR),
    CONCAT('{"id_product":',IFNULL(NEW.id_product,'null'),',"nombre":',QUOTE(NEW.nombre),',"precio":',IFNULL(NEW.precio,'null'),',"id_restaurante":',IFNULL(NEW.id_restaurante,'null'),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_productos_au AFTER UPDATE ON `productos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, new_data, created_by)
  VALUES(
    'productos','UPDATE', CAST(NEW.id_product AS CHAR),
    CONCAT('{"id_product":',IFNULL(OLD.id_product,'null'),',"nombre":',QUOTE(OLD.nombre),',"precio":',IFNULL(OLD.precio,'null'),',"id_restaurante":',IFNULL(OLD.id_restaurante,'null'),'}'),
    CONCAT('{"id_product":',IFNULL(NEW.id_product,'null'),',"nombre":',QUOTE(NEW.nombre),',"precio":',IFNULL(NEW.precio,'null'),',"id_restaurante":',IFNULL(NEW.id_restaurante,'null'),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_productos_ad AFTER DELETE ON `productos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'productos','DELETE', CAST(OLD.id_product AS CHAR),
    CONCAT('{"id_product":',IFNULL(OLD.id_product,'null'),',"nombre":',QUOTE(OLD.nombre),',"precio":',IFNULL(OLD.precio,'null'),',"id_restaurante":',IFNULL(OLD.id_restaurante,'null'),'}'),
    CURRENT_USER()
  );
END$$

-- Pedidos
CREATE TRIGGER trg_pedidos_ai AFTER INSERT ON `pedidos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, new_data, created_by)
  VALUES(
    'pedidos','INSERT', CAST(NEW.id_pedido AS CHAR),
    CONCAT('{"id_pedido":',IFNULL(NEW.id_pedido,'null'),',"fecha":',QUOTE(DATE_FORMAT(NEW.fecha, '%Y-%m-%d %H:%i:%s')),',"total":',IFNULL(NEW.total,'null'),',"id_repartidor":',IFNULL(NEW.id_repartidor,'null'),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_pedidos_au AFTER UPDATE ON `pedidos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, new_data, created_by)
  VALUES(
    'pedidos','UPDATE', CAST(NEW.id_pedido AS CHAR),
    CONCAT('{"id_pedido":',IFNULL(OLD.id_pedido,'null'),',"fecha":',QUOTE(DATE_FORMAT(OLD.fecha, '%Y-%m-%d %H:%i:%s')),',"total":',IFNULL(OLD.total,'null'),',"id_repartidor":',IFNULL(OLD.id_repartidor,'null'),'}'),
    CONCAT('{"id_pedido":',IFNULL(NEW.id_pedido,'null'),',"fecha":',QUOTE(DATE_FORMAT(NEW.fecha, '%Y-%m-%d %H:%i:%s')),',"total":',IFNULL(NEW.total,'null'),',"id_repartidor":',IFNULL(NEW.id_repartidor,'null'),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_pedidos_ad AFTER DELETE ON `pedidos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'pedidos','DELETE', CAST(OLD.id_pedido AS CHAR),
    CONCAT('{"id_pedido":',IFNULL(OLD.id_pedido,'null'),',"fecha":',QUOTE(DATE_FORMAT(OLD.fecha, '%Y-%m-%d %H:%i:%s')),',"total":',IFNULL(OLD.total,'null'),',"id_repartidor":',IFNULL(OLD.id_repartidor,'null'),'}'),
    CURRENT_USER()
  );
END$$

-- Detalle de pedidos
CREATE TRIGGER trg_detalle_pedidos_ai AFTER INSERT ON `detalle_pedidos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, new_data, created_by)
  VALUES(
    'detalle_pedidos','INSERT', CAST(NEW.id_detalle AS CHAR),
    CONCAT('{"id_detalle":',IFNULL(NEW.id_detalle,'null'),',"id_pedido":',IFNULL(NEW.id_pedido,'null'),',"id_producto":',IFNULL(NEW.id_producto,'null'),',"cantidad":',IFNULL(NEW.cantidad,'null'),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_detalle_pedidos_au AFTER UPDATE ON `detalle_pedidos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, new_data, created_by)
  VALUES(
    'detalle_pedidos','UPDATE', CAST(NEW.id_detalle AS CHAR),
    CONCAT('{"id_detalle":',IFNULL(OLD.id_detalle,'null'),',"id_pedido":',IFNULL(OLD.id_pedido,'null'),',"id_producto":',IFNULL(OLD.id_producto,'null'),',"cantidad":',IFNULL(OLD.cantidad,'null'),'}'),
    CONCAT('{"id_detalle":',IFNULL(NEW.id_detalle,'null'),',"id_pedido":',IFNULL(NEW.id_pedido,'null'),',"id_producto":',IFNULL(NEW.id_producto,'null'),',"cantidad":',IFNULL(NEW.cantidad,'null'),'}'),
    CURRENT_USER()
  );
END$$

CREATE TRIGGER trg_detalle_pedidos_ad AFTER DELETE ON `detalle_pedidos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'detalle_pedidos','DELETE', CAST(OLD.id_detalle AS CHAR),
    CONCAT('{"id_detalle":',IFNULL(OLD.id_detalle,'null'),',"id_pedido":',IFNULL(OLD.id_pedido,'null'),',"id_producto":',IFNULL(OLD.id_producto,'null'),',"cantidad":',IFNULL(OLD.cantidad,'null'),'}'),
    CURRENT_USER()
  );
END$$

DELIMITER ;

-- Fin del script create_db_railway.sql
