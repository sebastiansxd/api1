require('dotenv').config();
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
const logger = require('../utils/logger');

async function run() {
  const sqlFile = process.env.IMPORT_SQL_FILE ? path.resolve(process.env.IMPORT_SQL_FILE) : path.join(__dirname, '..', 'sistema_domicilios.sql');
  if (!fs.existsSync(sqlFile)) {
    throw new Error('No se encontró el archivo SQL: ' + sqlFile);
  }

  const sql = fs.readFileSync(sqlFile, 'utf8');

  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || '127.0.0.1',
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || undefined,
    port: process.env.DB_PORT ? parseInt(process.env.DB_PORT, 10) : undefined,
    multipleStatements: true
  });

  try {
    logger.info('Importando', sqlFile);
    await connection.query(sql);
    logger.info('Importación completada.');
  } finally {
    await connection.end();
  }
}

module.exports = { run };

if (require.main === module) {
  run().catch(err => {
    logger.error('Error al importar SQL:', err);
    process.exit(1);
  });
}
