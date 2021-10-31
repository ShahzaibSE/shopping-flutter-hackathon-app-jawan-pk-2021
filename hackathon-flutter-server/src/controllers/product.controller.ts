import mongoose from "mongoose";
import express, { Request, Response } from "express";
// Model Injector.
import { dbInjector } from "./dbInjector";

const product_model = dbInjector().product;

export const addProduct = async (req: Request, res: Response) => {
    try {
        const {uid, name, price, image, discount, description} = req.body;
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

    }catch(e) {
        throw e;
    }
}

export const deleteProduct = async (req: Request, res: Response) => {
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

export const getProducts = async (req: Request, res: Response) => {
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