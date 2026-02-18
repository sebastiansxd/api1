const express = require('express');
const router = express.Router();
const restauranteController = require('../controllers/restauranteController');

// Ruta para ver todos los restaurantes
router.get('/', restauranteController.getAllRestaurantes);

// Ruta para registrar un restaurante
router.post('/', restauranteController.createRestaurante);

// Obtener, actualizar y eliminar por id
router.get('/:id', restauranteController.getRestauranteById);
router.put('/:id', restauranteController.updateRestaurante);
router.delete('/:id', restauranteController.deleteRestaurante);

module.exports = router;