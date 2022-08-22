import 'package:ecommerce_rah/screens/products_details.dart';
import 'package:expandable/expandable.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:provider/provider.dart';

import '../api_service/pagination_service.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User _user;
  bool _isSigningOut = false;
  void signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  @override
  void initState() {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getdata();
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    cart.getCounter();
    super.initState();
  }

  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );
    CartProvider cart = Provider.of<CartProvider>(
      context,
    );
    List men = productProvider.data_list
        .where(
          (element) => element['category'] == 'men\'s clothing',
        )
        .toList();
    List women = productProvider.data_list
        .where(
          (element) => element['category'] == 'women\'s clothing',
        )
        .toList();
    List jewelery = productProvider.data_list
        .where(
          (element) => element['category'] == 'jewelery',
        )
        .toList();
    List electrics = productProvider.data_list
        .where(
          (element) => element['category'] == 'electronics',
        )
        .toList();

    // print('women ${data}');
    // print('women ${data.length}');
    // print(data[0]['title']);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey,
            elevation: 0,
            title: Text("BPPSHOP "),
            actions: [
              // MaterialButton(
              //     onPressed: () {
              //       signOut();

              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => LoginPage()));
              //     },
              //     child: Container(
              //       color: Colors.blueGrey,
              //       padding: EdgeInsets.all(10),
              //       child: Text('SignOut'),
              //     )),
              // IconButton(
              //     onPressed: () {
              //       signOut();

              //       Navigator.pop(context);
              //     },
              //     icon: Icon(Icons.delete))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(3.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    // isScrollable: true,
                    indicator: BoxDecoration(
                        color: Color.fromRGBO(102, 117, 102, 1),
                        borderRadius: BorderRadius.circular(5.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Men'),
                      Tab(text: 'Jewelery'),
                      Tab(text: 'Women'),
                      Tab(text: 'Electics'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          StaggeredGridView.countBuilder(
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.count(
                                      2, index.isEven ? 2 : 1),
                              mainAxisSpacing: 1.0,
                              crossAxisSpacing: 1.0,
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: productProvider.data_list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    var id =
                                        productProvider.data_list[index]['id'];
                                    var price = productProvider.data_list[index]
                                        ['price'];
                                    // var name = productProvider.data_list[index]
                                    //     ['title'];
                                    // var details = productProvider
                                    //     .data_list[index]['description'];
                                    // var image = productProvider.data_list[index]
                                    //     ['image'];
                                   // print(price);
                                    //print(id);
                                    showModalBottomSheet(
                                        useRootNavigator: true,
                                         isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) => Container(
                                            height: 500,
                                            child:
                                            ProductsDetails(
                                              productId: id.toString(),
                                                productPrice: price.toInt(),
                                                productName: productProvider
                                                        .data_list[index]
                                                    ['title'],
                                                products_details:
                                                    productProvider
                                                            .data_list[index]
                                                        ['description'],
                                                productsImage: productProvider
                                                        .data_list[index]
                                                    ['image'],
                                              ))
                                            );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: ((context) =>
                                    //             ProductsDetails(
                                    //               productPrice: productProvider
                                    //                       .data_list[index]
                                    //                   ['price'],
                                    //               productName: productProvider
                                    //                       .data_list[index]
                                    //                   ['title'],
                                    //               products_details:
                                    //                   productProvider
                                    //                           .data_list[index]
                                    //                       ['description'],
                                    //               productsImage: productProvider
                                    //                       .data_list[index]
                                    //                   ['image'],
                                    //             ))));
                                  },
                                  child: Container(
                                    child: Card(
                                        child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              child: Image.network(
                                                  productProvider
                                                      .data_list[index]['image']
                                                      .toString())),
                                        ),
                                        Text(
                                          productProvider.data_list[index]
                                                  ['title']
                                              .toString(),
                                          maxLines: 1,
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          'Price ${productProvider.data_list[index]['price'].toString()}',
                                          style: TextStyle(),
                                        )
                                      ],
                                    )),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              itemCount: men.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                // men.sort((a, b) => a['price'].compareTo(b['price']));
                                // for (var p in men) {
                                //  // print(p['price']);
                                // }
                                return Card(
                                    child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Image.network(
                                              men[index]['image'].toString())),
                                    ),
                                    Text(
                                      men[index]['title'].toString(),
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      'Price ${men[index]['price'].toString()}',
                                      style: TextStyle(),
                                    )
                                  ],
                                ));
                              })
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: GridView.builder(
                          itemCount: jewelery.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Expanded(
                                    child: Image.network(
                                        jewelery[index]['image'].toString()),
                                  )),
                                  Text(jewelery[index]['title'].toString()),
                                  Text(
                                    'Price ${jewelery[index]['price'].toString()}',
                                    style: TextStyle(),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              itemCount: women.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Image.network(women[index]
                                                    ['image']
                                                .toString())),
                                      ),
                                      Text(women[index]['title'].toString()),
                                      Text(
                                        'Price ${women[index]['price'].toString()}',
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              itemCount: electrics.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Image.network(
                                                electrics[index]['image']
                                                    .toString())),
                                      ),
                                      Text(
                                          electrics[index]['title'].toString()),
                                      Text(
                                        'Price ${electrics[index]['price'].toString()}',
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          )),
    );
  }
}

// 

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);
  @override
  State<MyTabbedPage> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  //List<Map<String, dynamic>> juwerieslist = [];

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'All'),
    Tab(text: 'Men'),
    Tab(text: 'Jewelery'),
    Tab(text: 'Women'),
    Tab(text: 'Electics'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getdata();

    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );
    List men = productProvider.data_list
        .where(
          (element) => element['category'] == 'men\'s clothing',
        )
        .toList();
    List women = productProvider.data_list
        .where(
          (element) => element['category'] == 'women\'s clothing',
        )
        .toList();
    List jewelery = productProvider.data_list
        .where(
          (element) => element['category'] == 'jewelery',
        )
        .toList();
    List electrics = productProvider.data_list
        .where(
          (element) => element['category'] == 'electronics',
        )
        .toList();

    // print('women ${data}');
    // print('women ${data.length}');
    // print(data[0]['title']);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // toolbarHeight: 80,
        // flexibleSpace: Container(decoration: BoxDecoration(
        //  // color: LinearGradient(colors: [])
        // ),),
        // backgroundColor:Color(0xffFF6000),
        title: AppBar(
          title: Text(' BPPSHOP'),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: productProvider.data_list.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    productProvider.data_list
                        .sort((a, b) => a['price'].compareTo(b['price']));
                    for (var p in productProvider.data_list) {
                      print(p['price']);
                    }
                    return Card(
                        child: Column(
                      children: [
                        Expanded(
                          child: Container(
                              child: Image.network(productProvider
                                  .data_list[index]['image']
                                  .toString())),
                        ),
                        Text(
                          productProvider.data_list[index]['title'].toString(),
                          style: TextStyle(),
                        ),
                        Text(
                          'Price ${productProvider.data_list[index]['price'].toString()}',
                          style: TextStyle(),
                        )
                      ],
                    ));
                  })
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: men.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    // men.sort((a, b) => a['price'].compareTo(b['price']));
                    // for (var p in men) {
                    //  // print(p['price']);
                    // }
                    return Card(
                        child: Column(
                      children: [
                        Expanded(
                          child: Container(
                              child: Image.network(
                                  men[index]['image'].toString())),
                        ),
                        Text(
                          men[index]['title'].toString(),
                          style: TextStyle(),
                        ),
                        Text(
                          'Price ${men[index]['price'].toString()}',
                          style: TextStyle(),
                        )
                      ],
                    ));
                  })
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: jewelery.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Container(
                              child: Expanded(
                            child: Image.network(
                                jewelery[index]['image'].toString()),
                          )),
                          Text(jewelery[index]['title'].toString()),
                          Text(
                            'Price ${jewelery[index]['price'].toString()}',
                            style: TextStyle(),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: women.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                                child: Image.network(
                                    women[index]['image'].toString())),
                          ),
                          Text(women[index]['title'].toString()),
                          Text(
                            'Price ${women[index]['price'].toString()}',
                            style: TextStyle(),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: electrics.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                                child: Image.network(
                                    electrics[index]['image'].toString())),
                          ),
                          Text(electrics[index]['title'].toString()),
                          Text(
                            'Price ${electrics[index]['price'].toString()}',
                            style: TextStyle(),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ]),
    );
  }
}
