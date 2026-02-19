const db = require('../config/db');

// Obtener todos los restaurantes
exports.getAllRestaurantes = async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM restaurantes');
        res.json(rows);
    } catch (error) {
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
        res.status(201).json({ mensaje: "Restaurante creado", id: result.insertId });
    } catch (error) {
        res.status(500).json({ mensaje: "Error al crear restaurante", error });
    }
};