const db = require('../config/db');
const logger = require('../utils/logger');

exports.getGanancias = async (req, res) => {
    try {
        logger.info('Calcular ganancias repartidores');
        const [rows] = await db.query(`
            SELECT rep.nombre, SUM(p.total) AS ganancias 
            FROM repartidores rep 
            JOIN pedidos p ON rep.id_repartidor = p.id_repartidor 
            GROUP BY rep.id_repartidor`);
        res.json(rows);
    } catch (error) {
        logger.error('Error calcular ganancias:', error);
        res.status(500).json({ mensaje: "Error al calcular ganancias", error });
    }
};

exports.createRepartidor = async (req, res) => {
    try {
        const { nombre, vehiculo, estado } = req.body;
        const [result] = await db.query(
            'INSERT INTO repartidores (nombre, vehiculo, estado) VALUES (?, ?, ?)',
            [nombre, vehiculo || null, estado || 'disponible']
        );
        logger.info('Repartidor creado', result.insertId, nombre);
        res.status(201).json({ mensaje: 'Repartidor creado', id: result.insertId });
    } catch (error) {
        logger.error('Error crear repartidor:', error);
        res.status(500).json({ mensaje: 'Error al crear repartidor', error });
    }
};

exports.getAllRepartidores = async (req, res) => {
    try {
        logger.info('Obtener todos los repartidores');
        const [rows] = await db.query('SELECT * FROM repartidores');
        res.json(rows);
    } catch (error) {
        logger.error('Error obtener repartidores:', error);
        res.status(500).json({ mensaje: 'Error al obtener repartidores', error });
    }
};

exports.getRepartidorById = async (req, res) => {
    try {
        const { id } = req.params;
        logger.info('Obtener repartidor por id', id);
        const [rows] = await db.query('SELECT * FROM repartidores WHERE id_repartidor = ?', [id]);
        if (!rows.length) return res.status(404).json({ mensaje: 'Repartidor no encontrado' });
        res.json(rows[0]);
    } catch (error) {
        logger.error('Error obtener repartidor:', error);
        res.status(500).json({ mensaje: 'Error al obtener repartidor', error });
    }
};

exports.updateRepartidor = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, vehiculo, estado } = req.body;
        const [result] = await db.query(
            'UPDATE repartidores SET nombre = ?, vehiculo = ?, estado = ? WHERE id_repartidor = ?',
            [nombre, vehiculo, estado, id]
        );
        if (result.affectedRows === 0) return res.status(404).json({ mensaje: 'Repartidor no encontrado' });
        logger.info('Repartidor actualizado', id);
        res.json({ mensaje: 'Repartidor actualizado' });
    } catch (error) {
        logger.error('Error actualizar repartidor:', error);
        res.status(500).json({ mensaje: 'Error al actualizar repartidor', error });
    }
};

exports.deleteRepartidor = async (req, res) => {
    try {
        const { id } = req.params;
        const [result] = await db.query('DELETE FROM repartidores WHERE id_repartidor = ?', [id]);
        if (result.affectedRows === 0) return res.status(404).json({ mensaje: 'Repartidor no encontrado' });
        logger.info('Repartidor eliminado', id);
        res.json({ mensaje: 'Repartidor eliminado' });
    } catch (error) {
        logger.error('Error eliminar repartidor:', error);
        res.status(500).json({ mensaje: 'Error al eliminar repartidor', error });
    }
};