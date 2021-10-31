import mongoose, {Schema} from "mongoose";

export const User:Schema  = new Schema({
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

export const Favourite = new Schema({
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
    image:{
        type: String,
    },
    discount: {
        type: String
    },
    price: {
        type: String,
    },
    category:{
        type: String,
    },
    createdAt: {
        type: String,
        default: new Date().toISOString()
    }
})

export const Profile = new Schema({
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

export const Category = new Schema({
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

export const Product = new Schema({
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

export const Cart = new Schema({
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