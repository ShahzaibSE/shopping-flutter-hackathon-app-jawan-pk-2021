import {User, Favourite, Profile, Product, Category, Cart} from "./../model";
import mongoose from "mongoose";

export const dbInjector = () => ({
    user: mongoose.model('User', User),
    favourite: mongoose.model('Favourite', Favourite),
    profile: mongoose.model('Profile', Profile),
    cart: mongoose.model('Cart', Cart),
    product: mongoose.model('Product', Product),
    category: mongoose.model('Category', Category)
});