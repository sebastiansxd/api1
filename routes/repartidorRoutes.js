const express = require('express');
const router = express.Router();
const repartidorController = require('../controllers/repartidorController');

router.get('/ganancias', repartidorController.getGanancias);

module.exports = router;