const express = require('express');
const router = express.Router();
const repartidorController = require('../controllers/repartidorController');

router.get('/', repartidorController.getAllRepartidores);
router.get('/ganancias', repartidorController.getGanancias);
router.get('/:id', repartidorController.getRepartidorById);
router.post('/', repartidorController.createRepartidor);
router.put('/:id', repartidorController.updateRepartidor);
router.delete('/:id', repartidorController.deleteRepartidor);

module.exports = router;