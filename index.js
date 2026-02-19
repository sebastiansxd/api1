const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

// Rutas
const restauranteRoutes = require('./routes/restauranteRoutes');
const pedidoRoutes = require('./routes/pedidoRoutes');
const repartidorRoutes = require('./routes/repartidorRoutes');
const reportesRoutes = require('./routes/reportesRoutes');

app.use('/api/restaurantes', restauranteRoutes);
app.use('/api/pedidos', pedidoRoutes);
app.use('/api/repartidores', repartidorRoutes);
app.use('/api/reportes', reportesRoutes);

app.get('/', (req, res) => {
    res.send('Bienvenido a la API de restaurantes. Usa /api/restaurantes, /api/pedidos, /api/repartidores, /api/reportes.');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
});