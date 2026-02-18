require('dotenv').config();
const mysql = require('mysql2/promise');

const { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT, DB_INIT_RETRIES, DB_INIT_RETRY_DELAY_MS } = process.env;

let pool;

async function initDatabase() {
    const maxRetries = DB_INIT_RETRIES ? parseInt(DB_INIT_RETRIES, 10) : 10;
    const delayMs = DB_INIT_RETRY_DELAY_MS ? parseInt(DB_INIT_RETRY_DELAY_MS, 10) : 5000;
    let attempt = 0;

    while (attempt < maxRetries) {
        attempt += 1;
        try {
            const tmpConn = await mysql.createConnection({
                host: DB_HOST,
                user: DB_USER,
                password: DB_PASSWORD,
                port: DB_PORT ? parseInt(DB_PORT, 10) : 3306,
                connectTimeout: 10000
            });

            if (DB_NAME) {
                await tmpConn.query(`CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`);
            }
            await tmpConn.end();

            pool = mysql.createPool({
                host: DB_HOST,
                user: DB_USER,
                password: DB_PASSWORD,
                database: DB_NAME,
                port: DB_PORT ? parseInt(DB_PORT, 10) : 3306,
                waitForConnections: true,
                connectionLimit: 10,
                charset: 'utf8mb4'
            });

            console.log('Conexión a la base de datos establecida.');
            return;
        } catch (err) {
            console.error(`Intento ${attempt} - Error inicializando la base de datos:`, err.message || err);
            if (attempt >= maxRetries) {
                console.error('No se pudo inicializar la base de datos tras varios intentos. Continuando sin pool activo.');
                return;
            }
            await new Promise(r => setTimeout(r, delayMs));
        }
    }
}

// Inicializar en background; otras llamadas esperarán a que termine
const ready = initDatabase();

module.exports = {
    query: async (...args) => {
        await ready;
        if (!pool) throw new Error('Pool de base de datos no inicializado');
        return pool.query(...args);
    },
    execute: async (...args) => {
        await ready;
        if (!pool) throw new Error('Pool de base de datos no inicializado');
        return pool.execute(...args);
    },
    getPool: async () => {
        await ready;
        if (!pool) throw new Error('Pool de base de datos no inicializado');
        return pool;
    }
};