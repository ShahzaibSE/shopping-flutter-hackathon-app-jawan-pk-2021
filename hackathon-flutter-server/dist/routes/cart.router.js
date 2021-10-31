"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const cart_controller_1 = require("./../controllers/cart.controller");
const cartRouter = express_1.Router();
cartRouter.get('/list', cart_controller_1.getCartItems);
cartRouter.post("/add", cart_controller_1.addtoCart);
cartRouter.delete("/delete/:_id", cart_controller_1.deleteFromCart);
exports.default = cartRouter;
