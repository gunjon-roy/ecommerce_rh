import 'dart:convert';

import 'package:ecommerce_rah/providers/cart_provider.dart';
import 'package:ecommerce_rah/providers/login_signup.dart';
import 'package:ecommerce_rah/providers/product_provider.dart';
import 'package:ecommerce_rah/providers/tokenstoreprovider.dart';
import 'package:ecommerce_rah/screens/product_page.dart';
import 'package:ecommerce_rah/screens/products_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CartProvider>(
          create: ((context) => CartProvider())),
      ChangeNotifierProvider<ProductProvider>(
          create: ((context) => ProductProvider())),
      ChangeNotifierProvider<SignupLogicModel>(
          create: ((context) => SignupLogicModel())),
      ChangeNotifierProvider<TokenProvider>(
          create: ((context) => TokenProvider())),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    ),
  ));
}

class paginationpage2 extends StatefulWidget {
  const paginationpage2({Key? key}) : super(key: key);

  @override
  _paginationpage2State createState() => _paginationpage2State();
}

class _paginationpage2State extends State<paginationpage2> {
  // We will fetch data from this Rest api
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http.get(
          Uri.parse('$_baseUrl?_page=$_page&_limit=$_limit'));
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res = await http.get(Uri.parse(
            '$_baseUrl?_page=$_page&_limit=$_limit'));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.length > 0) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text('Pagination Products'),
        centerTitle: true,
      ),
      body: _isFirstLoadRunning
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child: StaggeredGridView.countBuilder(
                controller: _controller,
                staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 2 : 1),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                crossAxisCount: 4,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ProductsDetails(
                                // productPrice: productProvider
                                //         .data_list[index]
                                //     ['price'],
                                // productName: productProvider
                                //         .data_list[index]
                                //     ['title'],
                                // products_details:
                                //     productProvider
                                //             .data_list[index]
                                //         ['description'],
                                // productsImage: productProvider
                                //         .data_list[index]
                                //     ['image'],
                              ))));
                    },
                    child: Container(
                      child: Card(
                          child: Column(
                            children: [
                              // Expanded(
                              //   child: Container(
                              //       child: Image.network(
                              //     _posts[index]['download_url'].toString(),
                              //     fit: BoxFit.fill,
                              //     width: double.infinity,
                              //   )),
                              // ),
                              Text(
                                _posts[index]['id'].toString(),
                                maxLines: 1,
                                style: TextStyle(),
                              ),
                              Text(
                                _posts[index]['body'].toString(),
                                maxLines: 1,
                                style: TextStyle(),
                              ),
                              Text(
                                _posts[index]['title'].toString(),
                                style: TextStyle(),
                              ),
                            ],
                          )),
                    ),
                  );
                }),
          ),

          // when the _loadMore function is running
          if (_isLoadMoreRunning == true)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child:  Container(
                  // color: Colors.white,
                  child: Center(
                    child: Text('Loading More Products',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ),

          // When nothing else to load
          if (_hasNextPage == false)
            Container(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              //color: Colors.amber,
              child: Center(
                child: Text('You have fetched all of the content',style:TextStyle(color:Colors.red,fontWeight:FontWeight.w600,),
                ),
              ),
            )],
      ),
    );
  }
}
