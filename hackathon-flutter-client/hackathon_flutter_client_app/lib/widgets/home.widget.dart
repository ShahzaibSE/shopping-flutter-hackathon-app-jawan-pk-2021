import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:hackathon_flutter_client_app/widgets/carts.widget.dart';
import 'package:hackathon_flutter_client_app/widgets/models/product.model.dart';
// Widgets.
import "./favourite.widget.dart";
import "./profileView.widget.dart";
import "./productCard.widget.dart";
import "./previousOrders.widget.dart";
import "search.widget.dart";
//
// Routes.
import "./home.routes.dart";
// Ads Database.
import 'models/Ads.model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<String> moreOptions = ["Profile", "Orders"];

  Widget generateFeaturedAds(int index) {
    return Container(
        // width: MediaQuery.of(context).size.width,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(children: <Widget>[
                    Container(
                      child: Image(
                          image: AssetImage(Ads.FeaturedAdsDB[index].imageUrl),
                          width: MediaQuery.of(context).size.width - 20,
                          height: 250),
                    ),
                  ]),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Text(
                              Ads.FeaturedAdsDB[index].title,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ])),
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  //   Container(
                  //       width: MediaQuery.of(context).size.width,
                  //       padding:
                  //           const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.star, color: Colors.yellow, size: 20),
                  //           Icon(Icons.star, color: Colors.yellow, size: 20),
                  //           Icon(Icons.star, color: Colors.yellow, size: 20),
                  //           Icon(Icons.star, color: Colors.yellow, size: 20),
                  //           Icon(Icons.star, color: Colors.yellow, size: 20),
                  //           Container(
                  //               padding: const EdgeInsets.only(left: 10, right: 10),
                  //               child: Text('5.0 (23 Reviews)',
                  //                   style: TextStyle(
                  //                       color: Colors.grey,
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.bold)))
                  //         ],
                  //       )),
                  // ])
                ])));
  }

  //
  Widget generateCategoryList(
      Icon icon, String categoryName, String numberOfItems) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                  // padding: const EdgeInsets.only(bottom: 25),
                  child: icon),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Text(categoryName,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Text(numberOfItems,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //
  //

  Widget generateAllAds(int index) {
    return Container(
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
                          image: AssetImage(Ads.allAdsDB[index].imageUrl),
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
                      Ads.allAdsDB[index].title,
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
    );
  }

  getAllProducts() async {
    try {
      return Ads.allAdsDB;
    } catch (e) {
      throw e;
    }
  }

  Widget generateProducts(int index, ProductModel product) {
    return ProductCard(product: product, index: index);
  }

  logout() async {
    print("Logout button tapped.");
    await FirebaseAuth.instance.signOut();
    //
    // Navigator.popUntil(
    //     context, (Route<dynamic> route) => route.settings.name == UserAuth.tag);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        // builder: (context) => const UserAuth(),
        builder: (context) => const HomeWidget(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Widget buildDrawer() {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      if (auth.currentUser == null) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                child: Text(
                  'Shop App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(
                        0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Colors.deepPurple,
                      Colors.purple
                    ], // red to yellow
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.input, size: 30),
                title: const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 14.5),
                ),
                onTap: () => {
                  Navigator.pop(context),
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, size: 30),
                title: const Text(
                  'My Cart',
                  style: TextStyle(fontSize: 14.5),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartListWidget(),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_rounded, size: 30),
                title: const Text(
                  'Favourite',
                  style: TextStyle(fontSize: 14.5),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavouriteWidget(),
                    ),
                  ),
                },
              ),
            ],
          ),
        );
      } else {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                child: Text(
                  'Enlightenment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('./assets/drawer-cover.jpeg'),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.input, size: 30),
                title: const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 14.5),
                ),
                onTap: () => {
                  Navigator.pop(context),
                },
              ),
              ListTile(
                leading: const Icon(Icons.verified_user, size: 30),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 14.5),
                ),
                // onTap: () => {Navigator.of(context).pop()},
                onTap: () => {
                  // getProfile();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewProfileWidget(),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, size: 30),
                title: const Text(
                  'My Cart',
                  style: TextStyle(fontSize: 14.5),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartListWidget(),
                    ),
                  ),
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite_rounded, size: 30),
                title: const Text(
                  'Favourite',
                  style: TextStyle(fontSize: 14.5),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavouriteWidget(),
                    ),
                  ),
                },
              ),
              const Divider(
                key: Key('divider-profile'),
                thickness: 1.0,
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, size: 30),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 14.5),
                ),
                onTap: logout,
              ),
              // ListTile(
              //   leading: const Icon(Icons.category),
              //   title: const Text('Category'),
              //   onTap: () => {},
              // ),
            ],
          ),
        );
      }
    } catch (e) {
      throw e;
    }
  }

  // Widget createPopUpMenu() {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          'Shopping App',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        // child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            child: Text('Featured',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 26)),
                            alignment: Alignment.topLeft,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: <Widget>[
                  generateFeaturedAds(0),
                  generateFeaturedAds(1),
                  generateFeaturedAds(2),
                  generateFeaturedAds(3),
                  generateFeaturedAds(4),
                  generateFeaturedAds(5),
                ]),
              )),
              //
              Stack(children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Text('More Categories',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold))))
              ]),
              //
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: <Widget>[
                    generateCategoryList(
                        Icon(Icons.local_drink, size: 30, color: Colors.purple),
                        'Clothes',
                        '5 Items'),
                    generateCategoryList(
                        Icon(Icons.bolt, size: 30, color: Colors.purple),
                        'Electronics',
                        '5 Items'),
                    generateCategoryList(
                        Icon(Icons.chair, size: 30, color: Colors.purple),
                        'Households',
                        '5 Items'),
                    generateCategoryList(
                        Icon(Icons.bolt, size: 30, color: Colors.purple),
                        'Appliances',
                        '5 Items'),
                    generateCategoryList(
                        Icon(Icons.double_arrow,
                            size: 30, color: Colors.purple),
                        'Other',
                        '15 Items'),
                  ])),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            child: Text('Items',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30)),
                            alignment: Alignment.topLeft,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                // height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Ads.allAdsDB.length,
                  itemBuilder: (BuildContext context, int index) {
                    return generateAllAds(index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
              backgroundColor: Colors.purple,
              child: Icon(Icons.search, size: 40),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchWidget(),
                  ),
                );
              })),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   child: Container(
      //     height: 80.0,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         Tooltip(
      //           message: "Home",
      //           showDuration: Duration(seconds: 3),
      //           child: Container(
      //             child: IconButton(
      //                 icon: Icon(Icons.home, size: 40, color: Colors.grey),
      //                 onPressed: () {
      //                   Navigator.of(context).pushReplacement(
      //                     HomeRoutes.createHomeScreen(),
      //                   );
      //                 }),
      //           ),
      //         ),
      //         Tooltip(
      //           message: "Favorites",
      //           showDuration: Duration(seconds: 3),
      //           child: Container(
      //             child: IconButton(
      //                 icon: Icon(Icons.favorite, size: 40, color: Colors.grey),
      //                 onPressed: () {
      //                   Navigator.of(context).push(
      //                     HomeRoutes.createFavouriteScreen(),
      //                   );
      //                 }),
      //             padding: const EdgeInsets.only(right: 20),
      //           ),
      //         ),
      //         Tooltip(
      //           message: "My Cart",
      //           showDuration: Duration(seconds: 3),
      //           child: Container(
      //             child: IconButton(
      //                 icon: Icon(Icons.add_shopping_cart,
      //                     size: 40, color: Colors.grey),
      //                 onPressed: () {
      //                   Navigator.of(context).push(
      //                     HomeRoutes.createCartScreen(),
      //                   );
      //                 }),
      //             padding: const EdgeInsets.only(left: 20),
      //           ),
      //         ),
      //         Tooltip(
      //           message: "Orders",
      //           showDuration: Duration(seconds: 3),
      //           child: Container(
      //             child: IconButton(
      //               icon: Icon(Icons.list, size: 40, color: Colors.grey),
      //               onPressed: () {
      //                 Navigator.of(context).push(
      //                   HomeRoutes.createPreviousOrdersScreen(),
      //                 );
      //               },
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
