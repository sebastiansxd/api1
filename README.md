# Restaurantes API

API básica para gestionar restaurantes, productos, repartidores y pedidos.

Comandos:

```bash
npm install
npm run db:import    # importa sistema_domicilios.sql (crea BD y tablas)
npm run db:seed      # inserta datos de ejemplo
npm run start        # arranca la API
npm run dev          # arranca con nodemon (dev)
```

Variables de entorno (ver `.env.example`): `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `PORT`, `AUTO_IMPORT`.

Endpoints principales (ejemplos):

- GET / -> mensaje de bienvenida

- Restaurantes
  - GET /api/restaurantes
  - GET /api/restaurantes/:id
  - POST /api/restaurantes  (body: `nombre`, `direccion`, `categoria`)
  - PUT /api/restaurantes/:id
  - DELETE /api/restaurantes/:id

- Productos
  - GET /api/productos
  - GET /api/productos?restaurante=<id>
  - GET /api/productos/:id
  - POST /api/productos (body: `nombre`, `precio`, `id_restaurante`)
  - PUT /api/productos/:id
  - DELETE /api/productos/:id

- Repartidores
  - GET /api/repartidores
  - GET /api/repartidores/:id
  - GET /api/repartidores/ganancias
  - POST /api/repartidores (body: `nombre`, `vehiculo`, `estado`)
  - PUT /api/repartidores/:id
  - DELETE /api/repartidores/:id

- Pedidos
  - GET /api/pedidos/pedidos-restaurante?id=<id_restaurante>
  - GET /api/pedidos/:id
  - POST /api/pedidos (body: `total`, `id_repartidor`, `items` = [{id_producto,cantidad}])
  - PUT /api/pedidos/:id
  - DELETE /api/pedidos/:id

Ejemplos de curl en el repo y scripts `db:import` / `db:seed` para preparar la base de datos.