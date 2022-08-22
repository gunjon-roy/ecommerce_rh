import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
  bool? islogged;
   setbooltoken(key,value)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    print('bookvalue $value');
  }

class TokenProvider extends ChangeNotifier {
  String? usernam;
  String? useremail;
  bool? islogged;
  String? image;
  settoken(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value!);

   
  }
  setbooltoken(key,value)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    print('bookvalue $value');
  }
   setImageToken(key,value)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('image link $value');
  }

  gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? 'Email  isn\'t set';
    String name = prefs.getString('name') ?? 'Name  isn\'t set';
    bool? islogeed = prefs.getBool("islogged");
    String imagelink = prefs.getString('image') ?? 'Hello';
    image = imagelink;
    usernam = name;
    useremail = email;
    islogged = islogeed;
    print(email + "<<<<<<,");
    print(name + "<<<<<<,");
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("name");
    prefs.remove("image");
    prefs.remove('islogged');
  }
//   showToken()async{
//  await gettoken();
//  notifyListeners();
// }
}
