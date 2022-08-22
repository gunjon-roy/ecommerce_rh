import 'package:ecommerce_rah/api_service/tuser_api_service.dart';
import 'package:flutter/material.dart';


class ProductProvider extends ChangeNotifier {
  List<Map<String,dynamic>> data_list = [];
  bool isloading = false;
  getdata() async {
    isloading=true;
    var data = await ApiService().getdata();
    data_list = data;
isloading=true;
// List <List<Map<String,dynamic>>> data_again=[];

  //   Map<String, Map<String, dynamic>> data_again = Map();

  //   data.forEach((element) {
     
  //  Map<String, dynamic>? temp = Map();

  //     temp = data_again[element['category']];
  //     temp![element['a']] = element;
  //     var map = data_again[element['category']] = temp;
  //   });

  //   print('data final  $data_again');

    notifyListeners();
  }
}


// var orderLines = <Map>[]; // creates an empty List<Map>

// orderLines.add({ 'number'  : '',
//               'Item' : '',
//               'Qty'  : ''
//              });