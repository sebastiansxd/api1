-- Triggers para la BD `railway` (ejecutar cada bloque por separado en DBeaver)
-- Instrucciones: Selecciona con el ratón un bloque 'CREATE TRIGGER ... END;' completo
-- y ejecútalo (Ctrl+Enter). No ejecutar todo el archivo de una vez si tu cliente no admite DELIMITER.

USE `railway`;

-- Trigger para rellenar created_at si es NULL (compatibilidad)
CREATE TRIGGER trg_audit_set_created_at
BEFORE INSERT ON audit_logs
FOR EACH ROW
BEGIN
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = NOW();
  END IF;
END;

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
END;

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
END;

CREATE TRIGGER trg_restaurantes_ad AFTER DELETE ON `restaurantes`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'restaurantes','DELETE', CAST(OLD.id_restaurante AS CHAR),
    CONCAT('{"id_restaurante":',IFNULL(OLD.id_restaurante,'null'),',"nombre":',QUOTE(OLD.nombre),',"direccion":',QUOTE(OLD.direccion),',"categoria":',QUOTE(OLD.categoria),'}'),
    CURRENT_USER()
  );
END;

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
END;

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
END;

CREATE TRIGGER trg_repartidores_ad AFTER DELETE ON `repartidores`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'repartidores','DELETE', CAST(OLD.id_repartidor AS CHAR),
    CONCAT('{"id_repartidor":',IFNULL(OLD.id_repartidor,'null'),',"nombre":',QUOTE(OLD.nombre),',"vehiculo":',QUOTE(OLD.vehiculo),',"estado":',QUOTE(OLD.estado),'}'),
    CURRENT_USER()
  );
END;

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
END;

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
END;

CREATE TRIGGER trg_productos_ad AFTER DELETE ON `productos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'productos','DELETE', CAST(OLD.id_product AS CHAR),
    CONCAT('{"id_product":',IFNULL(OLD.id_product,'null'),',"nombre":',QUOTE(OLD.nombre),',"precio":',IFNULL(OLD.precio,'null'),',"id_restaurante":',IFNULL(OLD.id_restaurante,'null'),'}'),
    CURRENT_USER()
  );
END;

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
END;

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
END;

CREATE TRIGGER trg_pedidos_ad AFTER DELETE ON `pedidos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'pedidos','DELETE', CAST(OLD.id_pedido AS CHAR),
    CONCAT('{"id_pedido":',IFNULL(OLD.id_pedido,'null'),',"fecha":',QUOTE(DATE_FORMAT(OLD.fecha, '%Y-%m-%d %H:%i:%s')),',"total":',IFNULL(OLD.total,'null'),',"id_repartidor":',IFNULL(OLD.id_repartidor,'null'),'}'),
    CURRENT_USER()
  );
END;

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
END;

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
END;

CREATE TRIGGER trg_detalle_pedidos_ad AFTER DELETE ON `detalle_pedidos`
FOR EACH ROW
BEGIN
  INSERT INTO audit_logs(table_name, action, record_id, old_data, created_by)
  VALUES(
    'detalle_pedidos','DELETE', CAST(OLD.id_detalle AS CHAR),
    CONCAT('{"id_detalle":',IFNULL(OLD.id_detalle,'null'),',"id_pedido":',IFNULL(OLD.id_pedido,'null'),',"id_producto":',IFNULL(OLD.id_producto,'null'),',"cantidad":',IFNULL(OLD.cantidad,'null'),'}'),
    CURRENT_USER()
  );
END;
