const db = require('../config/db');
const logger = require('../utils/logger');

// Obtener todos los restaurantes
exports.getAllRestaurantes = async (req, res) => {
    try {
        logger.info('Obteniendo todos los restaurantes');
        const [rows] = await db.query('SELECT * FROM restaurantes');
        res.json(rows);
    } catch (error) {
        logger.error('Error obtener restaurantes:', error);
        res.status(500).json({ mensaje: "Error al obtener restaurantes", error });
    }
};

// Crear un nuevo restaurante (Parte del CRUD obligatorio)
exports.createRestaurante = async (req, res) => {
    try {
        const { nombre, direccion, categoria } = req.body;
        const [result] = await db.query(
            'INSERT INTO restaurantes (nombre, direccion, categoria) VALUES (?, ?, ?)',
            [nombre, direccion, categoria]
        );
        logger.info('Restaurante creado', result.insertId, nombre);
        res.status(201).json({ mensaje: "Restaurante creado", id: result.insertId });
    } catch (error) {
        logger.error('Error crear restaurante:', error);
        res.status(500).json({ mensaje: "Error al crear restaurante", error });
    }
};

exports.getRestauranteById = async (req, res) => {
    try {
        const { id } = req.params;
        logger.info('Obtener restaurante por id', id);
        const [rows] = await db.query('SELECT * FROM restaurantes WHERE id_restaurante = ?', [id]);
        if (!rows.length) return res.status(404).json({ mensaje: 'Restaurante no encontrado' });
        res.json(rows[0]);
    } catch (error) {
        logger.error('Error obtener restaurante:', error);
        res.status(500).json({ mensaje: 'Error al obtener restaurante', error });
    }
};

exports.updateRestaurante = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, direccion, categoria } = req.body;
        const [result] = await db.query(
            'UPDATE restaurantes SET nombre = ?, direccion = ?, categoria = ? WHERE id_restaurante = ?',
            [nombre, direccion, categoria, id]
        );
        if (result.affectedRows === 0) return res.status(404).json({ mensaje: 'Restaurante no encontrado' });
        logger.info('Restaurante actualizado', id);
        res.json({ mensaje: 'Restaurante actualizado' });
    } catch (error) {
        logger.error('Error actualizar restaurante:', error);
        res.status(500).json({ mensaje: 'Error al actualizar restaurante', error });
    }
};

exports.deleteRestaurante = async (req, res) => {
    try {
        const { id } = req.params;
        const [result] = await db.query('DELETE FROM restaurantes WHERE id_restaurante = ?', [id]);
        if (result.affectedRows === 0) return res.status(404).json({ mensaje: 'Restaurante no encontrado' });
        logger.info('Restaurante eliminado', id);
        res.json({ mensaje: 'Restaurante eliminado' });
    } catch (error) {
        logger.error('Error eliminar restaurante:', error);
        res.status(500).json({ mensaje: 'Error al eliminar restaurante', error });
    }
};