"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getProducts = exports.deleteProduct = exports.addProduct = exports.searchByCategory = void 0;
// Model Injector.
const dbInjector_1 = require("./dbInjector");
const product_model = dbInjector_1.dbInjector().product;
const searchByCategory = async (req, res) => {
    try {
        const category = req.query.category;
        const productList = await product_model.find({ category });
        if (!productList) {
            res.setHeader("Content-Type", "application/json");
            res.status(400).send({
                status: false,
                resCode: 400,
                message: "Product of respected category not found",
                isError: true,
            });
        }
        else {
            res.setHeader("Content-Type", "application/json");
            res.status(200).send({
                status: true,
                resCode: 200,
                message: "Successfully found product with respect to category",
                isError: false,
                data: productList,
            });
        }
    }
    catch (e) {
        throw e;
    }
};
exports.searchByCategory = searchByCategory;
const addProduct = async (req, res) => {
    try {
        const { uid, name, price, image, discount, description } = req.body;
        let newProduct = new product_model({
            uid,
            name,
            price,
            image,
            description,
            discount,
        });
        newProduct.save((err, data) => {
            res.setHeader("Content-Type", "application/json");
            res.status(200).send({
                status: true,
                resCode: 200,
                message: "Product added successfully",
                isError: false,
                data,
            });
        });
        //   }
    }
    catch (e) {
        throw e;
    }
};
exports.addProduct = addProduct;
const deleteProduct = async (req, res) => {
    try {
        var deletedDocument = await product_model.deleteOne({
            _id: req.params._id,
        });
        if (deletedDocument) {
            res.setHeader("Content-Type", "application/json");
            res.status(200).send({
                status: true,
                resCode: 200,
                message: "Product deleted successfully",
                isError: false,
            });
        }
        else {
            res.setHeader("Content-Type", "application/json");
            res.status(424).send({
                status: false,
                resCode: 424,
                message: "Product could not be deleted",
                isError: true
            });
        }
    }
    catch (e) {
        throw e;
    }
};
exports.deleteProduct = deleteProduct;
const getProducts = async (req, res) => {
    try {
        const uid = req.query.uid;
        const productList = await product_model.find({});
        if (!productList) {
            res.setHeader("Content-Type", "application/json");
            res.status(400).send({
                status: false,
                resCode: 400,
                message: "No product found",
                isError: true,
            });
        }
        else {
            res.setHeader("Content-Type", "application/json");
            res.status(200).send({
                status: true,
                resCode: 200,
                message: "Products found successfully",
                isError: false,
                data: productList,
            });
        }
    }
    catch (err) {
        throw err;
    }
};
exports.getProducts = getProducts;
