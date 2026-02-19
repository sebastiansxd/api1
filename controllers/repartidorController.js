const db = require('../config/db');

exports.getGanancias = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT rep.nombre, SUM(p.total) AS ganancias 
            FROM repartidores rep 
            JOIN pedidos p ON rep.id_repartidor = p.id_repartidor 
            GROUP BY rep.id_repartidor`);
        res.json(rows);
    } catch (error) {
        res.status(500).json({ mensaje: "Error al calcular ganancias", error });
    }
};