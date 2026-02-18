const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());
const logger = require('./utils/logger');

// Request logging
app.use((req, res, next) => {
    logger.info(req.method, req.originalUrl);
    next();
});

// Importar Rutas
const pedidoRoutes = require('./routes/pedidoRoutes');
const repartidorRoutes = require('./routes/repartidorRoutes');
const restauranteRoutes = require('./routes/restauranteRoutes');
const productoRoutes = require('./routes/productoRoutes');

// Usar Rutas
app.use('/api/restaurantes', restauranteRoutes);
app.use('/api/productos', productoRoutes);
app.use('/api/pedidos', pedidoRoutes);
app.use('/api/repartidores', repartidorRoutes);

// Ruta raíz para mostrar mensaje de bienvenida
app.get('/', (req, res) => {
    res.send('Bienvenido a la API de restaurantes. Usa /api/restaurantes, /api/pedidos o /api/repartidores.');
});

const PORT = process.env.PORT || 3000;
async function start() {
    if (process.env.AUTO_IMPORT === 'true') {
        try {
            const importer = require('./scripts/import_sql');
            await importer.run();
        } catch (err) {
            logger.error('Importación automática falló:', err);
            // no salir; continuar para permitir debugging
        }
    }

    app.listen(PORT, () => {
        logger.info(`Servidor corriendo en el puerto ${PORT}`);
    });
}

start();

const restauranteRoutes = require('./routes/restauranteRoutes');
const productoRoutes = require('./routes/productoRoutes');




// ...
