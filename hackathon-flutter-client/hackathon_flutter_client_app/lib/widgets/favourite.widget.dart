import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Models.
import "./models/product.model.dart";
// Widget.
import "./productDetails.widget.dart";

class FavouriteWidget extends StatefulWidget {
  const FavouriteWidget({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<FavouriteWidget> {
  getFavourites() async {}

  deleteFavourite(int index) async {}

  addToCart() async {}

  Widget buildFavourite(ProductModel product, int index) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                isFavourite: false,
                index: index,
                product: ProductModel(
                  name: product.name,
                  imageUrl: product.imageUrl,
                  description: product.description,
                  discount: product.discount,
                ),
              ),
            ),
          );
        },
        child: Container(
          child: Slidable(
            actionPane: const SlidableBehindActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              // minLeadingWidth: 60,
              contentPadding: const EdgeInsets.all(10),
              leading: FittedBox(
                child: product.imageUrl == null
                    ? Image(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/enlightnment-app-logo.jpeg",
                        ),
                        width: MediaQuery.of(context).size.width / 4,
                        height: 80,
                      )
                    : Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          product.imageUrl.toString(),
                        ),
                        width: MediaQuery.of(context).size.width / 4,
                        height: 80,
                      ),
              ),
              title: Container(
                // padding: const EdgeInsets.only(top: 10),
                child: Text(
                  product.name!.characters.take(30).toString() + "...",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              trailing: const Tooltip(
                message: "drag to left",
                showDuration: Duration(seconds: 3),
                child: Icon(Icons.drag_indicator),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    deleteFavourite(
                      ProductModel.products[index]["_id"],
                    );
                  });
                },
              ),
              IconSlideAction(
                color: Colors.red,
                icon: Icons.add_shopping_cart_rounded,
                onTap: () {
                  setState(() {
                    addToCart();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourites",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getFavourites(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LimitedBox(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    snapshot.data.length,
                    (index) => buildFavourite(
                      ProductModel(
                        name: ProductModel.products[index]['name'],
                        imageUrl: ProductModel.products[index]['imageUrl'],
                        description: ProductModel.products[index]
                            ['description'],
                      ),
                      index,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: const SpinKitCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
              color: Colors.deepPurple,
            );
          }
        },
      ),
    );
  }
}
