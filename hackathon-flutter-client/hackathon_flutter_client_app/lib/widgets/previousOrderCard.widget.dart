import "package:flutter/material.dart";
// Models
import "./models/product.model.dart";

class PreviousOrderCard extends StatefulWidget {
  const PreviousOrderCard(
      {Key? key, required this.previousOrder, required this.index})
      : super(key: key);
  final PreviousOrderModel previousOrder;
  final int index;

  @override
  _PreviousOrderCardState createState() => _PreviousOrderCardState();
}

class _PreviousOrderCardState extends State<PreviousOrderCard> {
  @override
  Widget build(BuildContext context) {
    var address = widget.previousOrder.address;
    var price = widget.previousOrder.price;
    var orderNumber = widget.previousOrder.orderNumber;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height),
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Text(
                  "Order Item: $orderNumber",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.deepPurple,
                child: Text(
                  "Address: $address",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                color: Colors.deepPurple,
                child: Text(
                  "Order Item: $price",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
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
