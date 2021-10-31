import express, {Router} from "express";
import app from "./../server";
import {getProducts, addProduct, deleteProduct} from "./../controllers/product.controller";

const productRouter: Router = Router();

productRouter.get('/list', getProducts)
productRouter.post("/add", addProduct);
productRouter.delete("/delete/:_id", deleteProduct);

export default productRouter;