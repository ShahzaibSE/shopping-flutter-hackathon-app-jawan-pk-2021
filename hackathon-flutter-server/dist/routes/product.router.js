"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const product_controller_1 = require("./../controllers/product.controller");
const productRouter = express_1.Router();
productRouter.get('/list', product_controller_1.getProducts);
productRouter.post("/add", product_controller_1.addProduct);
productRouter.delete("/delete/:_id", product_controller_1.deleteProduct);
exports.default = productRouter;
