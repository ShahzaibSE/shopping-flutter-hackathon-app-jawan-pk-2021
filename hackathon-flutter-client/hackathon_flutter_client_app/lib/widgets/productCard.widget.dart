import "package:flutter/material.dart";
import 'package:hackathon_flutter_client_app/widgets/productDetails.widget.dart';
import "./models/product.model.dart";
import "./productDetails.widget.dart";

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product, required this.index})
      : super(key: key);

  final ProductModel product;
  final int index;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return LimitedBox(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(
                    isFavourite: true,
                    index: widget.index,
                    product: ProductModel(
                      name: widget.product.name,
                      imageUrl: widget.product.imageUrl,
                      description: widget.product.description,
                      discount: widget.product.discount,
                    ),
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      Align(
                          child: Container(
                            child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  widget.product.imageUrl.toString(),
                                ),
                                width: 150,
                                height: 150),
                            alignment: Alignment.center,
                          ),
                          alignment: Alignment.center),
                    ],
                  ),
                  Stack(children: [
                    Align(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            widget.product.name.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        alignment: Alignment.center),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}
