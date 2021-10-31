import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:skeleton_loader/skeleton_loader.dart";
import "dart:convert";

// Model.
import "./models/product.model.dart";

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  String hintText = "Search";
  List<dynamic> searchResults = [];
  var _isLoading = true, _isInit = false;

  searchProducts() async {
    try {
      var uri = Uri.http(
        "localhost:3000",
        "/store/search",
        {'search': searchController.text},
      );
      var response = await http.get(uri);
      print(uri);
      print(response.body);
      List jsonResponse = jsonDecode(response.body)['data'];

      // setState() {
      print('Populating searchList');
      searchResults = jsonResponse;
      return jsonResponse;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (search) {
            searchProducts();
          },
          controller: searchController,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: "Search",
            suffixIcon: GestureDetector(
              onTap: () {
                searchController.clear();
              },
              child: const Icon(
                Icons.clear,
                color: Colors.white,
                size: 25,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: searchProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return GridView.builder(
              itemBuilder: (ctx, i) {
                ProductModel searchedProduct = searchResults[i];
                return Card(
                  child: GridTile(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image(
                            image: NetworkImage(
                              searchedProduct.imageUrl.toString(),
                            ),
                          ),
                        ),
                        Text(searchedProduct.name.toString()),
                        Text(searchedProduct.price.toString()),
                      ],
                    ),
                  ),
                );
              },
              itemCount: searchResults.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
            );
          } else {
            return SkeletonGridLoader(
              builder: Card(
                color: Colors.transparent,
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 10,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 70,
                        height: 10,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              items: 9,
              itemsPerRow: 3,
              period: Duration(seconds: 2),
              highlightColor: Colors.purpleAccent,
              direction: SkeletonDirection.ltr,
              childAspectRatio: 1,
            );
          }
        },
      ),
    );
  }
}
