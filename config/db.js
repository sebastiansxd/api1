require('dotenv').config();
const mysql = require('mysql2/promise');
const { URL } = require('url');

// re awd¿fwf3lkg4jkogo4variables de entorno con varios nombres de fallback (Railway usa distintos nombres)
const env = process.env;

function parseDatabaseUrl(databaseUrl) {
    try {
        const u = new URL(databaseUrl);
        return {
            host: u.hostname,
            port: u.port || undefined,
            user: u.username || undefined,
            password: u.password || undefined,
            database: u.pathname ? u.pathname.replace(/^\//, '') : undefined
        };
    } catch (e) {
        return {};
    }
}

const fromUrl = env.DATABASE_URL ? parseDatabaseUrl(env.DATABASE_URL) : {};

const DB_HOST = env.DB_HOST || env.MYSQLHOST || fromUrl.host;
const DB_PORT = env.DB_PORT || env.MYSQLPORT || fromUrl.port;
const DB_USER = env.DB_USER || env.MYSQLUSER || fromUrl.user;
const DB_PASSWORD = env.DB_PASSWORD || env.MYSQLPASSWORD || fromUrl.password;
const DB_NAME = env.DB_NAME || env.MYSQLDATABASE || fromUrl.database;

const DB_INIT_RETRY_DELAY_MS = env.DB_INIT_RETRY_DELAY_MS ? parseInt(env.DB_INIT_RETRY_DELAY_MS, 10) : 5000;
const DB_SSL = (env.DB_SSL || env.MYSQL_SSL || '').toLowerCase() === 'true';

let pool;

// Deferred ready promise that resolves only when pool is successfully created
let readyResolve;
const ready = new Promise(resolve => { readyResolve = resolve; });

async function initDatabase() {
    let attempt = 0;
    console.log('DB config:', { host: DB_HOST, port: DB_PORT, user: DB_USER, database: DB_NAME, ssl: DB_SSL });

    // Retry indefinitely until success (safer for managed DBs that may be temporarily unreachable)
    while (true) {
        attempt += 1;
        try {
            const connOptions = {
                host: DB_HOST,
                user: DB_USER,
                password: DB_PASSWORD,
                port: DB_PORT ? parseInt(DB_PORT, 10) : 3306,
                connectTimeout: 10000
            };
            if (DB_SSL) connOptions.ssl = { rejectUnauthorized: false };

            const tmpConn = await mysql.createConnection(connOptions);

            if (DB_NAME) {
                // Use a safe CREATE DATABASE statement
                await tmpConn.query(`CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci`);
            }
            await tmpConn.end();

            const poolOptions = {
                host: DB_HOST,
                user: DB_USER,
                password: DB_PASSWORD,
                database: DB_NAME,
                port: DB_PORT ? parseInt(DB_PORT, 10) : 3306,
                waitForConnections: true,
                connectionLimit: env.DB_CONNECTION_LIMIT ? parseInt(env.DB_CONNECTION_LIMIT, 10) : 10,
                charset: 'utf8mb4'
            };
            if (DB_SSL) poolOptions.ssl = { rejectUnauthorized: false };

            pool = mysql.createPool(poolOptions);
            console.log('Conexión a la base de datos establecida.');
            readyResolve();
            return;
        } catch (err) {
            console.error(`Intento ${attempt} - Error inicializando la base de datos:`);
            console.error(err && err.stack ? err.stack : err);
            await new Promise(r => setTimeout(r, DB_INIT_RETRY_DELAY_MS));
        }
    }
}

// Inicia la inicialización en background
initDatabase();

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