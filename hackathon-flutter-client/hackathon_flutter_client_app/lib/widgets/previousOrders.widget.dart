import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "previousOrderCard.widget.dart";
// Model.
import "./models/product.model.dart";

class PreviousOrdersWidget extends StatefulWidget {
  const PreviousOrdersWidget({Key? key}) : super(key: key);

  @override
  _PreviousOrdersWidgetState createState() => _PreviousOrdersWidgetState();
}

class _PreviousOrdersWidgetState extends State<PreviousOrdersWidget> {
  getPreviousOrders() async {}
  Widget buildPreviousOrders(PreviousOrderModel previousOrder, int index) {
    return PreviousOrderCard(previousOrder: previousOrder, index: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Previous Orders",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getPreviousOrders(),
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
                    (index) => buildPreviousOrders(
                      PreviousOrderModel(
                        address: PreviousOrderModel.previousOrderList[index]
                            ['address'],
                        price: PreviousOrderModel.previousOrderList[index]
                            ['price'],
                        orderNumber: index.toString(),
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
