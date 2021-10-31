"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getCartItems = exports.deleteFromCart = exports.addtoCart = void 0;
// Model Injector.
const dbInjector_1 = require("./dbInjector");
const cart_model = dbInjector_1.dbInjector().cart;
const addtoCart = async (req, res) => {
    try {
        const { uid, name, price, image, quantity } = req.body;
        //
        const existingItemCart = await cart_model.findOne({ name });
        //
        if (existingItemCart) {
            const updateItemInCart = await cart_model.updateOne({ name }, { $set: { quantity: quantity + 1 } });
            const updatedItem = await cart_model.findOne({ name });
            res.status(200).send({
                resCode: 200,
                status: true,
                isError: false,
                message: "Item quantity updated",
                data: updatedItem
            });
        }
        else {
            let newItemCart = new cart_model({
                uid,
                name,
                price,
                image,
                quantity: 1
            });
            newItemCart.save((err, data) => {
                res.setHeader("Content-Type", "application/json");
                res.status(200).send({
                    status: true,
                    resCode: 200,
                    message: "Added to cart successfully",
                    isError: false,
                    data,
                });
            });
        }
    }
    catch (e) {
        throw e;
    }
};
exports.addtoCart = addtoCart;
const deleteFromCart = async (req, res) => {
    try {
        var deletedDocument = await cart_model.deleteOne({
            _id: req.params._id,
        });
        if (deletedDocument) {
            res.setHeader("Content-Type", "application/json");
            res.status(200).send({
                status: true,
                resCode: 200,
                message: "Cart Item deleted successfully",
                isError: false,
            });
        }
        else {
            res.setHeader("Content-Type", "application/json");
            res.status(424).send({
                status: false,
                resCode: 424,
                message: "Cart Item could not be deleted",
                isError: true
            });
        }
    }
    catch (e) {
        throw e;
    }
};
exports.deleteFromCart = deleteFromCart;
const getCartItems = async (req, res) => {
    try {
        const uid = req.query.uid;
        const cartList = await cart_model.find({ uid });
        if (!cartList) {
            res.setHeader("Content-Type", "application/json");
            res.status(400).send({
                status: false,
                resCode: 400,
                message: "Cart is empty",
                isError: true,
            });
        }
        else {
            res.setHeader("Content-Type", "application/json");
            res.status(200).send({
                status: true,
                resCode: 200,
                message: "Successfully found cart list",
                isError: false,
                data: cartList,
            });
        }
    }
    catch (err) {
        throw err;
    }
};
exports.getCartItems = getCartItems;
