"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Cart = exports.Product = exports.Category = exports.Profile = exports.Favourite = exports.User = void 0;
const mongoose_1 = require("mongoose");
exports.User = new mongoose_1.Schema({
    firstname: {
        type: String,
        required: true
    },
    lastname: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true
    },
});
// export const Favourite = new Schema({
//     uid: {
//         type: String,
//         required: true
//     },
//     favourites: {
//         type: Array,
//         default: [{}]
//     }
// });
exports.Favourite = new mongoose_1.Schema({
    uid: {
        type: String,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    description: {
        type: String,
    },
    image: {
        type: String,
    },
    discount: {
        type: String
    },
    price: {
        type: String,
    },
    category: {
        type: String,
    },
    createdAt: {
        type: String,
        default: new Date().toISOString()
    }
});
exports.Profile = new mongoose_1.Schema({
    uid: {
        type: String,
        required: true
    },
    imageUrl: {
        type: String,
    },
    name: {
        type: String,
        required: true
    },
    address: {
        type: String,
    },
    card_number: {
        type: String
    }
});
exports.Category = new mongoose_1.Schema({
    logo: {
        type: String,
    },
    name: {
        type: String
    },
    createdAt: {
        type: String
    }
});
exports.Product = new mongoose_1.Schema({
    uid: {
        type: String,
        required: true
    },
    image: {
        type: String
    },
    name: {
        type: String,
        required: true
    },
    price: {
        type: String,
    },
    category: {
        type: String,
    },
    description: {
        type: String,
    },
    discount: {
        type: String,
    },
    createdAt: {
        type: String,
        default: new Date().toISOString()
    }
});
exports.Cart = new mongoose_1.Schema({
    uid: {
        type: String,
        required: true
    },
    image: {
        type: String
    },
    name: {
        type: String,
        required: true
    },
    price: {
        type: String,
    },
    quantity: {
        type: Number
    },
    createdAt: {
        type: String,
        default: new Date().toISOString()
    }
});
