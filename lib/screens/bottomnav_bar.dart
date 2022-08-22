
import 'package:ecommerce_rah/screens/product_page.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import '../Google_login/signin_screen.dart';
import '../Google_login/userProfile_screen.dart';
import '../main.dart';
import '../providers/cart_provider.dart';
import '../providers/tokenstoreprovider.dart';
import 'cart_screen.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar(
      {this.currentTab = 0,
        this.currentScreen = const MyHomePage(),
        this.fromdetailPage = false});
  int currentTab = 0;
  bool fromdetailPage = false;
  Widget currentScreen ;
  @override
  _BottomNavBarState createState() =>
      _BottomNavBarState(currentTab, currentScreen);
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Properties & Variables needed

  _BottomNavBarState(this.currentTab, this.currentScreen);
  int currentTab; // to keep track of active tab index
  TokenProvider? tokenProvider;
  final List<Widget> screens = [
    MyHomePage(),
    paginationpage2(),
    CartScreen(),
    UserInfoScreen(),

  ];
  bool islogin = true;
  @override
  void initState() {
    TokenProvider tokenProvider =
    Provider.of<TokenProvider>(context, listen: false);
    tokenProvider.gettoken();

    // TODO: implement initState
    super.initState();
  }

  // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen; //= Home_Page(); // Our first view in viewport
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    TokenProvider tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Color(0xFFE37D4E),
      //     onPressed: () {
      //       // Navigator.of(context)
      //       //     .push(MaterialPageRoute(builder: (context) => OrderDetails()));
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.all(16.0),
      //       child: Center(
      //         child: Badge(
      //           badgeContent: Text(
      //             itemCount.toString(),
      //             style: TextStyle(color: Colors.white),
      //           ),
      //           child: Icon(Icons.shopping_bag_outlined),
      //         ),
      //       ),
      //     )),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        // notchMargin: 6,
        child: Container(
            color: Colors.grey[300],
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MyHomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0
                              ? Color.fromRGBO(102, 117, 102, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Color.fromRGBO(102, 117, 102, 1)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            paginationpage2(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.favorite_border_outlined,
                          color: currentTab == 1
                              ? Color.fromRGBO(102, 117, 102, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Pagination',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color.fromRGBO(102, 117, 102, 1)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right Tab bar icons

                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            CartScreen(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Badge(
                          badgeContent: Consumer<CartProvider>(
                            builder: (context, value, child) {
                              return Text(
                                value.counter.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                          //  position: const BadgePosition(start: 30, bottom: 30),
                          child: Icon(
                            Icons.shopping_cart,
                            color: currentTab == 2
                                ? Color.fromRGBO(102, 117, 102, 1)
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          'Cart',
                          style: TextStyle(
                            color: currentTab == 2
                                ? Color.fromRGBO(102, 117, 102, 1)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {

                        (currentScreen = UserInfoScreen());
                        // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: currentTab == 3
                              ? Color.fromRGBO(102, 117, 102, 1)
                              : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 3
                                ? Color.fromRGBO(102, 117, 102, 1)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ])),
      ),
    );
  }
}
