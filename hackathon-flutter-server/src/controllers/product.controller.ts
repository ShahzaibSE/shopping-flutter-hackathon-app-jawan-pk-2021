import mongoose from "mongoose";
import express, { Request, Response } from "express";
// Model Injector.
import { dbInjector } from "./dbInjector";

const product_model = dbInjector().product;

export const addtoCart = async (req: Request, res: Response) => {
    try {
        const {uid, name, price, image, discount, description} = req.body;
        //
        const existingItemCart = await product_model.findOne({name});
        //
        if(existingItemCart) {
            res.status(200).send({
                resCode: 200,
                status: true,
                isError: false,
                message: "Product already exists."
            });
        }else {
            let newItemCart = new product_model({
              uid,
              name,
              price,
              image,
              description,
              discount,
            });
            newItemCart.save((err, data) => {
              res.setHeader("Content-Type", "application/json");
              res.status(200).send({
                status: true,
                resCode: 200,
                message: "Product added successfully",
                isError: false,
                data,
              });
            });
          }

    }catch(e) {
        throw e;
    }
}

export const deleteFromCart = async (req: Request, res: Response) => {
   try{ 
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
      }else {
        res.setHeader("Content-Type", "application/json");
        res.status(424).send({
            status: false,
            resCode: 424,
            message: "Product could not be deleted",
            isError: true
        });
      }
   }catch(e) {
       throw e;
   }
}

export const getCartItems = async (req: Request, res: Response) => {
    try {
        const uid = req.query.uid;
        const cartList: Array<any> = await product_model.find({});
        if (!cartList) {
            res.setHeader("Content-Type", "application/json");
            res.status(400).send({
            status: false,
            resCode: 400,
            message: "No product found",
            isError: true,
            });
        } else {
            res.setHeader("Content-Type", "application/json");
            res.status(200).send({
            status: true,
            resCode: 200,
            message: "Products found successfully",
            isError: false,
            data: cartList,
            });
        }
        } catch (err) {
            throw err;
        }
}