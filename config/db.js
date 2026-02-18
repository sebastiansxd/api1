require('dotenv').config();
const mysql = require('mysql2/promise');

const { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT } = process.env;

let pool;

async function initDatabase() {
    try {
        const tmpConn = await mysql.createConnection({
            host: DB_HOST,
            user: DB_USER,
            password: DB_PASSWORD,
            port: DB_PORT ? parseInt(DB_PORT, 10) : 3306
        });

        await tmpConn.query(`CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`);
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
    } catch (err) {
        console.error('Error inicializando la base de datos:', err);
        throw err;
    }
}

// Inicializar en background; otras llamadas esperarán a que termine
const ready = initDatabase();

module.exports = {
    query: async (...args) => {
        await ready;
        return pool.query(...args);
    },
    execute: async (...args) => {
        await ready;
        return pool.execute(...args);
    },
    getPool: async () => {
        await ready;
        return pool;
    }
};