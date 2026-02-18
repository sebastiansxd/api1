const db = require('../config/db');
const logger = require('../utils/logger');

exports.getAllProductos = async (req, res) => {
    try {
        const { restaurante } = req.query;
        let rows;
        logger.info('Obtener productos', { restaurante });
        if (restaurante) {
            [rows] = await db.query('SELECT * FROM productos WHERE id_restaurante = ?', [restaurante]);
        } else {
            [rows] = await db.query('SELECT * FROM productos');
        }
        res.json(rows);
    } catch (error) {
        logger.error('Error obtener productos:', error);
        res.status(500).json({ mensaje: 'Error al obtener productos', error });
    }
};

exports.getProductoById = async (req, res) => {
    try {
        const { id } = req.params;
        logger.info('Obtener producto por id', id);
        const [rows] = await db.query('SELECT * FROM productos WHERE id_product = ?', [id]);
        if (!rows.length) return res.status(404).json({ mensaje: 'Producto no encontrado' });
        res.json(rows[0]);
    } catch (error) {
        logger.error('Error obtener producto:', error);
        res.status(500).json({ mensaje: 'Error al obtener producto', error });
    }
};

exports.createProducto = async (req, res) => {
    try {
        const { nombre, precio, id_restaurante } = req.body;
        const [result] = await db.query(
            'INSERT INTO productos (nombre, precio, id_restaurante) VALUES (?, ?, ?)',
            [nombre, precio, id_restaurante]
        );
        logger.info('Producto creado', result.insertId, nombre);
        res.status(201).json({ mensaje: 'Producto creado', id: result.insertId });
    } catch (error) {
        logger.error('Error crear producto:', error);
        res.status(500).json({ mensaje: 'Error al crear producto', error });
    }
};

exports.updateProducto = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, precio, id_restaurante } = req.body;
        const [result] = await db.query(
            'UPDATE productos SET nombre = ?, precio = ?, id_restaurante = ? WHERE id_product = ?',
            [nombre, precio, id_restaurante, id]
        );
        if (result.affectedRows === 0) return res.status(404).json({ mensaje: 'Producto no encontrado' });
        logger.info('Producto actualizado', id);
        res.json({ mensaje: 'Producto actualizado' });
    } catch (error) {
        logger.error('Error actualizar producto:', error);
        res.status(500).json({ mensaje: 'Error al actualizar producto', error });
    }
};

exports.deleteProducto = async (req, res) => {
    try {
        const { id } = req.params;
        const [result] = await db.query('DELETE FROM productos WHERE id_product = ?', [id]);
        if (result.affectedRows === 0) return res.status(404).json({ mensaje: 'Producto no encontrado' });
        logger.info('Producto eliminado', id);
        res.json({ mensaje: 'Producto eliminado' });
    } catch (error) {
        logger.error('Error eliminar producto:', error);
        res.status(500).json({ mensaje: 'Error al eliminar producto', error });
    }
};
