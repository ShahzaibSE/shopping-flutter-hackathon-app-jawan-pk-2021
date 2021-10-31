import express, {Router} from "express";
import app from "./../server";
import {getCartItems, addtoCart, deleteFromCart} from "./../controllers/cart.controller";

export const cartRouter: Router = Router();

cartRouter.get('/list', getCartItems)
cartRouter.post("/add", addtoCart);
cartRouter.delete("/delete/:_id", deleteFromCart);