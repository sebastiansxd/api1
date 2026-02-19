const express = require('express');
const router = express.Router();
const pedidoController = require('../controllers/pedidoController');

router.get('/pedidos-restaurante', pedidoController.getPedidosPorRestaurante);
router.post('/', pedidoController.createPedido);

module.exports = router;