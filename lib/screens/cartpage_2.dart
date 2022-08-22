import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:provider/provider.dart';

import '../database/db_helper.dart';
import '../models/cart_model.dart';
import '../providers/cart_provider.dart';

class CartScreen2 extends StatefulWidget {
  const CartScreen2({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen2> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen2> {
  DBHelper? dbHelper = DBHelper();
  List<bool> tapped = [];

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: const Text(
          ' Shopping Cart',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          // Badge(
          //   badgeContent: Consumer<CartProvider>(
          //     builder: (context, value, child) {
          //       return Text(
          //         value.counter.toString(),
          //         style: const TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.bold),
          //       );
          //     },
          //   ),
          //   position: const BadgePosition(start: 30, bottom: 30),
          //   child: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(Icons.shopping_cart),
          //   ),
          // ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
                if (provider.cart.isEmpty) {
                  return const Center(
                      child: Text(
                    'Your Cart is Empty',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.cart.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // color: Colors.blueGrey.shade200,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                  height: 80,
                                  width: 80,
                                  image:
                                      NetworkImage(provider.cart[index].image!),
                                ),
                                SizedBox(
                                  width: 170,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: 'Name: ',
                                              style: TextStyle(
                                                  color:
                                                      Colors.blueGrey.shade800,
                                                  fontSize: 16.0),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '${provider.cart[index].productName!}\n',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                        ),
                                        RichText(
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: 'Unit: ',
                                              style: TextStyle(
                                                  color:
                                                      Colors.blueGrey.shade800,
                                                  fontSize: 16.0),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '${provider.cart[index].unitTag!}\n',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                        ),
                                        RichText(
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: 'Price: ' r"$",
                                              style: TextStyle(
                                                  color:
                                                      Colors.blueGrey.shade800,
                                                  fontSize: 16.0),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '${provider.cart[index].productPrice!}\n',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          dbHelper!.deleteCartItem(int.parse(
                                              provider.cart[index].id!
                                                  .toString()));
                                          provider.removeItem(int.parse(provider
                                              .cart[index].id!
                                              .toString()));
                                          provider.removeCounter();
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red.shade800,
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ValueListenableBuilder<int>(
                                        valueListenable:
                                            provider.cart[index].quantity!,
                                        builder: (context, val, child) {
                                          return PlusMinusButtons(
                                            addQuantity: () {
                                              cart.addQuantity(
                                                  provider.cart[index].id!);
                                              dbHelper!
                                                  .updateQuantity(Cart(
                                                      id: index,
                                                      productId:
                                                          index.toString(),
                                                      productName: provider
                                                          .cart[index]
                                                          .productName,
                                                      initialPrice: provider
                                                          .cart[index]
                                                          .initialPrice,
                                                      productPrice: provider
                                                          .cart[index]
                                                          .productPrice,
                                                      quantity: ValueNotifier(
                                                          provider.cart[index]
                                                              .quantity!.value),
                                                      unitTag: provider
                                                          .cart[index].unitTag,
                                                      image: provider
                                                          .cart[index].image))
                                                  .then((value) {
                                                setState(() {
                                                  cart.addTotalPrice(
                                                      double.parse(provider
                                                          .cart[index]
                                                          .productPrice
                                                          .toString()));
                                                });
                                              });
                                            },
                                            deleteQuantity: () {
                                              cart.deleteQuantity(
                                                  provider.cart[index].id!);
                                              cart.removeTotalPrice(
                                                  double.parse(provider
                                                      .cart[index].productPrice
                                                      .toString()));
                                            },
                                            text: val.toString(),
                                          );
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (BuildContext context, value, Widget? child) {
              final ValueNotifier<int?> totalPrice = ValueNotifier(null);
              for (var element in value.cart) {
                totalPrice.value =
                    (element.productPrice! * element.quantity!.value) +
                        (totalPrice.value ?? 0);
              }
              return Column(
                children: [
                  ValueListenableBuilder<int?>(
                      valueListenable: totalPrice,
                      builder: (context, val, child) {
                        return ReusableWidget(
                            title: 'Sub-Total',
                            value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
                      }),
                ],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Colors.black.withOpacity(.2),
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.2),
                borderRadius: BorderRadius.circular(50)),
            child: GestureDetector(
                onTap: deleteQuantity,
                child: Center(
                    child: Icon(
                  Icons.remove,
                  size: 22,
                )))),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.2),
                borderRadius: BorderRadius.circular(50)),
            child: GestureDetector(
                onTap: addQuantity,
                child: const Icon(
                  Icons.add,
                  size: 22,
                ))),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Text(value.toString(),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
