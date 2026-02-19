const db = require('../config/db');

exports.getProductosMasVendidos = async (req, res) => {
  try {
    const limit = parseInt(req.query.limit) || 10;
    const [rows] = await db.query(
      `SELECT prod.id_product, prod.nombre, SUM(dp.cantidad) AS vendidos
       FROM detalle_pedidos dp
       JOIN productos prod ON dp.id_producto = prod.id_product
       GROUP BY prod.id_product
       ORDER BY vendidos DESC
       LIMIT ?`,
      [limit]
    );
    res.json(rows);
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al obtener productos más vendidos', error });
  }
};
