const db = require('../config/db');

exports.getPedidosPorRestaurante = async (req, res) => {
    try {
        const { id } = req.query;
        const [rows] = await db.query(`
            SELECT p.*, r.nombre AS restaurante
            FROM pedidos p
            JOIN detalle_pedidos dp ON p.id_pedido = dp.id_pedido
            JOIN productos prod ON dp.id_producto = prod.id_product
            JOIN restaurantes r ON prod.id_restaurante = r.id_restaurante
            WHERE r.id_restaurante = ?`, [id]);
        res.json(rows);
    } catch (error) {
        res.status(500).json({ mensaje: 'Error al obtener pedidos', error });
    }
};

exports.createPedido = async (req, res) => {
    try {
        const { id_repartidor, items } = req.body;
        if (!items || !Array.isArray(items) || items.length === 0) {
            return res.status(400).json({ mensaje: 'Se requiere arreglo "items" con productos y cantidades' });
        }

        // Verificar conectividad con la BD antes de seguir
        try {
            await db.query('SELECT 1');
        } catch (connErr) {
            return res.status(503).json({ mensaje: 'Base de datos no disponible. Comprueba variables de entorno y acceso.', error: connErr.code || connErr.message });
        }
        // Implementación simplificada: usar el pool directamente sin transacciones
        const [r] = await db.query('INSERT INTO pedidos (total, id_repartidor) VALUES (?, ?)', [0, id_repartidor || null]);
        const id_pedido = r.insertId;

        let total = 0;
        for (const item of items) {
            const id_producto = item.id_producto || item.producto_id || item.productId;
            const cantidad = parseInt(item.cantidad || item.cant || 1);
            if (!id_producto) {
                return res.status(400).json({ mensaje: 'Cada item debe tener "id_producto" y "cantidad"' });
            }

            const [prodRows] = await db.query('SELECT precio FROM productos WHERE id_product = ?', [id_producto]);
            if (prodRows.length === 0) {
                return res.status(400).json({ mensaje: `Producto no encontrado: ${id_producto}` });
            }
            const precio = parseFloat(prodRows[0].precio) || 0;
            total += precio * cantidad;

            await db.query('INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad) VALUES (?, ?, ?)', [id_pedido, id_producto, cantidad]);
        }

        await db.query('UPDATE pedidos SET total = ? WHERE id_pedido = ?', [total.toFixed(2), id_pedido]);
        res.status(201).json({ mensaje: 'Pedido creado', id_pedido, total: Number(total.toFixed(2)) });
    } catch (error) {
        console.error('Error createPedido:', error);
        res.status(500).json({ mensaje: 'Error al crear pedido', error: error.message || error });
    }
};