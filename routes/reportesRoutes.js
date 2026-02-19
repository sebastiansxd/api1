const express = require('express');
const router = express.Router();
const reportController = require('../controllers/reportController');

router.get('/productos-mas-vendidos', reportController.getProductosMasVendidos);

module.exports = router;
