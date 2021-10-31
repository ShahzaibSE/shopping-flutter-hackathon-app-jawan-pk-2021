import cookieParser from 'cookie-parser';
import morgan from 'morgan';
import path from 'path';
import helmet from 'helmet';
import cors from 'cors';

import express, { NextFunction, Request, Response } from 'express';
import StatusCodes from 'http-status-codes';
import 'express-async-errors';

import mongoose from 'mongoose';
// Routes. 
import user_router from "./routes/user.router";
import favourite_router from "./routes/favourite.router";
import profile_router from "./routes/profile.router";
import cartRouter from "./routes/cart.router";
import productRouter from "./routes/product.router";

const app = express();
const { BAD_REQUEST } = StatusCodes;

/************************************************************************************
 *                              Set basic Mongodb Settings.
 ***********************************************************************************/

const mongodb_con_string = "mongodb+srv://shahzaibnoor:zx11223344@cluster0.0g70j.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
mongoose.connect(mongodb_con_string, {
    // useCreateIndex: true,
    // useUnifiedTopology: true,
    // useNewUrlParser: true,
    // useFindAndModify: false
});

/************************************************************************************
 *                              Set basic express settings
 ***********************************************************************************/

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cookieParser());
app.use(cors());

// Routes
app.use("/user", user_router);
app.use("/favourite", favourite_router);
app.use("/profile", profile_router);
app.use("/cart", cartRouter);
app.use("/product", productRouter);

// Show routes called in console during development
if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
}

// Security
if (process.env.NODE_ENV === 'production') {
    app.use(helmet());
}


// Print API errors
// eslint-disable-next-line @typescript-eslint/no-unused-vars
// app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
//     logger.err(err, true);
//     return res.status(BAD_REQUEST).json({
//         error: err.message,
//     });
// });



/************************************************************************************
 *                              Serve front-end content
 ***********************************************************************************/

const viewsDir = path.join(__dirname, 'views');
app.set('views', viewsDir);
const staticDir = path.join(__dirname, 'public');
app.use(express.static(staticDir));
app.get('*', (req: Request, res: Response) => {
    res.sendFile('index.html', {root: viewsDir});
});

// Export express instance
export default app;
