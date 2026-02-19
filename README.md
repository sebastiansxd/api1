API de Restaurantes - Grupo 8

Requisitos mínimos para desplegar en Render usando una base de datos en Railway:

- Variables de entorno (en Render -> Environment):
	- `DB_HOST` - host de la base de datos (Railway)
	- `DB_USER` - usuario
	- `DB_PASSWORD` - contraseña
	- `DB_NAME` - nombre de la base de datos (ej. `railway`)
	- `PORT` - opcional (Render asigna automáticamente una)

Comandos locales:

```bash
npm install
npm start
```

Endpoints principales (GET/POST mínimos):

- `GET /api/restaurantes` - listar restaurantes
- `POST /api/restaurantes` - crear restaurante
- `GET /api/pedidos/pedidos-restaurante?id={id}` - pedidos de un restaurante
- `GET /api/repartidores/ganancias` - ganancias por repartidor
- `GET /api/reportes/productos-mas-vendidos?limit=10` - productos más vendidos

Notas de despliegue:
- Añade las variables de entorno de Railway en el panel de Render.
- Asegúrate de ejecutar el script SQL proporcionado en tu base de datos Railway para crear las tablas.
