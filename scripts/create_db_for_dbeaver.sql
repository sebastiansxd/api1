-- Ajustado para crear/usar la base de datos `railway`
DROP DATABASE IF EXISTS `railway`;
CREATE DATABASE IF NOT EXISTS `railway` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `railway`;

-- Restaurantes
CREATE TABLE `railway`.`restaurantes` (
  `id_restaurante` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_restaurante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Repartidores
CREATE TABLE `railway`.`repartidores` (
  `id_repartidor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `vehiculo` varchar(50) DEFAULT NULL,
  `estado` enum('disponible','ocupado') DEFAULT 'disponible',
  PRIMARY KEY (`id_repartidor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Productos (depende de restaurantes)
CREATE TABLE `railway`.`productos` (
  `id_product` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `id_restaurante` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_product`),
  KEY `id_restaurante` (`id_restaurante`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `railway`.`restaurantes` (`id_restaurante`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Pedidos (depende de repartidores)
CREATE TABLE `railway`.`pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) DEFAULT NULL,
  `id_repartidor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_repartidor` (`id_repartidor`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_repartidor`) REFERENCES `railway`.`repartidores` (`id_repartidor`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Detalle de pedidos (depende de pedidos y productos)
CREATE TABLE `railway`.`detalle_pedidos` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `railway`.`pedidos` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `railway`.`productos` (`id_product`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;

-- Nota: este script usa nombres calificados (sistema_domicilios.<tabla>) para evitar errores
-- en clientes que no ejecutan el `USE` correctamente. Ejecuta todo como script en DBeaver.
