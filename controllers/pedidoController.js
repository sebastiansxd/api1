const db = require('../config/db');
const logger = require('../utils/logger');

exports.getPedidosPorRestaurante = async (req, res) => {
    try {
        const { id } = req.query; // Filtro mediante query params [cite: 136]
        logger.info('Obtener pedidos por restaurante', id);
        const [rows] = await db.query(`
            SELECT p.*, r.nombre AS restaurante 
            FROM pedidos p 
            JOIN detalle_pedidos dp ON p.id_pedido = dp.id_pedido
            JOIN productos prod ON dp.id_producto = prod.id_product
            JOIN restaurantes r ON prod.id_restaurante = r.id_restaurante
            WHERE r.id_restaurante = ?`, [id]);
        res.json(rows); // Respuesta en formato JSON [cite: 138]
    } catch (error) {
        logger.error('Error obtener pedidos por restaurante:', error);
        res.status(500).json({ mensaje: "Error al obtener pedidos", error }); // Manejo de errores [cite: 137]
    }
};

// Crear pedido con detalle
exports.createPedido = async (req, res) => {
    try {
        const { total, id_repartidor, items } = req.body;
        // items = [{ id_producto, cantidad }]
        const [result] = await db.query(
            'INSERT INTO pedidos (total, id_repartidor) VALUES (?, ?)',
            [total || 0, id_repartidor || null]
        );
        const id_pedido = result.insertId;

        if (Array.isArray(items) && items.length) {
            const insertDetailPromises = items.map(i => {
                return db.query('INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad) VALUES (?, ?, ?)', [id_pedido, i.id_producto, i.cantidad]);
            });
            await Promise.all(insertDetailPromises);
        }

        logger.info('Pedido creado', id_pedido, { total, id_repartidor, itemsCount: Array.isArray(items)?items.length:0 });
        res.status(201).json({ mensaje: 'Pedido creado', id_pedido });
    } catch (error) {
        logger.error('Error crear pedido:', error);
        res.status(500).json({ mensaje: 'Error al crear pedido', error });
    }
};

exports.createPedido = async (req, res) => {
    try {
        const { total, id_repartidor, items } = req.body;
        // items = [{ id_producto, cantidad }]
        const [result] = await db.query(
            'INSERT INTO pedidos (total, id_repartidor) VALUES (?, ?)',
            [total || 0, id_repartidor || null]
        );
        const id_pedido = result.insertId;

        if (Array.isArray(items) && items.length) {
            const insertDetailPromises = items.map(i => {
                return db.query('INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad) VALUES (?, ?, ?)', [id_pedido, i.id_producto, i.cantidad]);
            });
            await Promise.all(insertDetailPromises);
        }

        res.status(201).json({ mensaje: 'Pedido creado', id_pedido });
    } catch (error) {
        res.status(500).json({ mensaje: 'Error al crear pedido', error });
    }
};

exports.getPedidoById = async (req, res) => {
    try {
        const { id } = req.params;
        logger.info('Obtener pedido por id', id);
        const [pRows] = await db.query('SELECT * FROM pedidos WHERE id_pedido = ?', [id]);
        if (!pRows.length) return res.status(404).json({ mensaje: 'Pedido no encontrado' });
        const [detalle] = await db.query('SELECT dp.*, prod.nombre, prod.precio FROM detalle_pedidos dp JOIN productos prod ON dp.id_producto = prod.id_product WHERE dp.id_pedido = ?', [id]);
        res.json({ pedido: pRows[0], detalle });
    } catch (error) {
        logger.error('Error obtener pedido:', error);
        res.status(500).json({ mensaje: 'Error al obtener pedido', error });
    }
};

exports.updatePedido = async (req, res) => {
    try {
        const { id } = req.params;
        const { total, id_repartidor, items } = req.body;
        const [result] = await db.query('UPDATE pedidos SET total = ?, id_repartidor = ? WHERE id_pedido = ?', [total, id_repartidor, id]);
        if (result.affectedRows === 0) return res.status(404).json({ mensaje: 'Pedido no encontrado' });

        if (Array.isArray(items)) {
            // reemplazar detalle: borrar existentes y crear nuevos
            await db.query('DELETE FROM detalle_pedidos WHERE id_pedido = ?', [id]);
            const insertPromises = items.map(i => db.query('INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad) VALUES (?, ?, ?)', [id, i.id_producto, i.cantidad]));
            await Promise.all(insertPromises);
        }

        logger.info('Pedido actualizado', id);
        res.json({ mensaje: 'Pedido actualizado' });
    } catch (error) {
        logger.error('Error actualizar pedido:', error);
        res.status(500).json({ mensaje: 'Error al actualizar pedido', error });
    }
};

exports.deletePedido = async (req, res) => {
    try {
        const { id } = req.params;
        // eliminar detalle primero
        await db.query('DELETE FROM detalle_pedidos WHERE id_pedido = ?', [id]);
        const [result] = await db.query('DELETE FROM pedidos WHERE id_pedido = ?', [id]);
        if (result.affectedRows === 0) return res.status(404).json({ mensaje: 'Pedido no encontrado' });
        logger.info('Pedido eliminado', id);
        res.json({ mensaje: 'Pedido eliminado' });
    } catch (error) {
        logger.error('Error eliminar pedido:', error);
        res.status(500).json({ mensaje: 'Error al eliminar pedido', error });
    }
};