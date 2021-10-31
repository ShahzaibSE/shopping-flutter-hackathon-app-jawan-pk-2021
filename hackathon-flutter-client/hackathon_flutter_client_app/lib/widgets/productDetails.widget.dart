import "package:flutter/material.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import "package:firebase_auth/firebase_auth.dart";
import "dart:convert";
import "package:http/http.dart" as http;
// Model.
import "./models/product.model.dart";
// Widget
import "./user-auth-container.widget.dart";

class ProductDetails extends StatefulWidget {
  const ProductDetails(
      {Key? key,
      required this.product,
      required this.index,
      required this.isFavourite})
      : super(key: key);
  final ProductModel product;
  final int index;
  final bool isFavourite;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  addToCart(ProductModel product) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      //
      if (auth.currentUser == null) {
        // Open up Modal Bottom Sheet.
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => const UserAuth(),
        );
      } else {
        final User user = auth.currentUser as User;
        final uid = user.uid;
        var uri = Uri.http('localhost:3000', '/cart/add');
        var newCartItem = {'uid': uid, 'name': product.name};
        if (product.imageUrl != null) {
          newCartItem['imageUrl'] = product.imageUrl.toString();
        }
        if (product.category != null) {
          newCartItem['category'] = product.category.toString();
        }
        if (product.category != null) {
          newCartItem['name'] = product.name.toString();
        }
        if (product.category != null) {
          newCartItem['price'] = product.price.toString();
        }

        var response = await http.post(uri, body: newCartItem);
        var jsonResponse = jsonDecode(response.body);

        const newCartItemAddedDialog = AlertDialog(
            title: Text(
              "Added to Cart!",
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ));
        showDialog(
            context: context, builder: (context) => newCartItemAddedDialog);

        return jsonResponse;
      }
    } catch (e) {
      throw e;
    }
  }

  addToFavourite(ProductModel product) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      if (auth.currentUser == null) {
        // Open up Modal Bottom Sheet.
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => const UserAuth(),
        );
      } else {
        final User user = auth.currentUser as User;
        final uid = user.uid;
        var uri = Uri.http('localhost:3000', '/favourite/add');
        var newFavourite = {'uid': uid, 'name': product.name};
        if (product.imageUrl != null) {
          newFavourite['imageUrl'] = product.imageUrl.toString();
        }
        if (product.description != null) {
          newFavourite['description'] = product.description.toString();
        }
        if (product.category != null) {
          newFavourite['category'] = product.category.toString();
        }
        if (product.category != null) {
          newFavourite['name'] = product.name.toString();
        }
        if (product.category != null) {
          newFavourite['price'] = product.price.toString();
        }
        if (product.category != null) {
          newFavourite['discount'] = product.discount.toString();
        }
        if (product.category != null) {
          newFavourite['description'] = product.description.toString();
        }

        var response = await http.post(uri, body: newFavourite);
        var jsonResponse = jsonDecode(response.body);
        //
        if (jsonResponse['status'] == false) {
          const ifAlreadyFavourite = AlertDialog(
              title: Text(
                "Favourite already exists.",
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ));
          showDialog(
              context: context, builder: (context) => ifAlreadyFavourite);
        } else {
          const newFavouriteAdded = AlertDialog(
              title: Text(
                "Favourite added!",
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ));
          showDialog(context: context, builder: (context) => newFavouriteAdded);
        }
        //
        return jsonResponse;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: addToFavourite(widget.product),
          icon: Icon(Icons.favorite_rounded),
        ),
        title: Text(
          widget.product.name.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              key: Key(
                widget.index.toString(),
              ),
              onTap: () {
                // setState(() {
                addToCart(widget.product);
                // });
              },
              child: GestureDetector(
                child: Icon(
                  Icons.favorite_rounded,
                  size: 26.0,
                  key: Key(
                    widget.index.toString(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: widget.product.imageUrl == null
                    ? Image(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "assets/enlightnment-app-logo.jpeg",
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                      )
                    : Image(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          widget.product.imageUrl.toString(),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                      ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  widget.product.name.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  widget.product.discount.toString() + "% Off",
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  // child: const Text(
                  //   "Imran Ahmed Khan Niazi HI PP is the 22nd and current prime minister of Pakistan. He is also the chairman of the Pakistan Tehreek-e-Insaf. Before entering politics, Khan was an international cricketer and captain of the Pakistan national cricket team, which he led to victory in the 1992 Cricket World Cup.",
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //   ),
                  child: Text(
                    widget.product.description.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
