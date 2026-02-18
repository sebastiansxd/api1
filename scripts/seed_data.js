require('dotenv').config();
const db = require('../config/db');
const logger = require('../utils/logger');

async function seed() {
  try {
    // Restaurantes
    await db.query("INSERT INTO restaurantes (nombre, direccion, categoria) VALUES (?, ?, ?)", ['Pizzeria Uno', 'Calle Principal 1', 'Italiana']);
    await db.query("INSERT INTO restaurantes (nombre, direccion, categoria) VALUES (?, ?, ?)", ['Sushi Place', 'Avenida Central 5', 'Asiática']);

    // Obtener ids de restaurantes creados
    const [restRows] = await db.query('SELECT id_restaurante FROM restaurantes');
    const idR1 = restRows[0] ? restRows[0].id_restaurante : null;

    // Productos
    if (idR1) {
      await db.query('INSERT INTO productos (nombre, precio, id_restaurante) VALUES (?, ?, ?)', ['Pizza Margarita', 25000, idR1]);
      await db.query('INSERT INTO productos (nombre, precio, id_restaurante) VALUES (?, ?, ?)', ['Pizza Pepperoni', 30000, idR1]);
    }

    // Repartidores
    await db.query('INSERT INTO repartidores (nombre, vehiculo, estado) VALUES (?, ?, ?)', ['Juan Perez', 'Moto', 'disponible']);
    await db.query('INSERT INTO repartidores (nombre, vehiculo, estado) VALUES (?, ?, ?)', ['Ana Gomez', 'Bicicleta', 'disponible']);

    const [repRows] = await db.query('SELECT id_repartidor FROM repartidores');
    const idRep = repRows[0] ? repRows[0].id_repartidor : null;

    // Pedidos y detalle (si hay productos)
    const [prodRows] = await db.query('SELECT id_product FROM productos');
    if (prodRows.length && idRep) {
      const [pRes] = await db.query('INSERT INTO pedidos (total, id_repartidor) VALUES (?, ?)', [55000, idRep]);
      const idPedido = pRes.insertId;
      await db.query('INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad) VALUES (?, ?, ?)', [idPedido, prodRows[0].id_product, 1]);
    }

    logger.info('Seed completado');
  } catch (err) {
    logger.error('Error en seed:', err);
    process.exitCode = 1;
  }
}

if (require.main === module) {
  seed().then(() => process.exit(process.exitCode || 0));
} else {
  module.exports = { seed };
}
