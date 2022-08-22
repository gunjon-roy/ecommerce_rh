import 'package:flutter/material.dart';

class SignupLogicModel extends ChangeNotifier {
  bool _isselected = true;
  bool get isselected => _isselected;
  void checkcolor() {
    _isselected = false;
    notifyListeners();
  }

  void checkcolor2() {
    _isselected = true;
    notifyListeners();
  }

  //Check Box''''
  var ischected = false;

  bool get _ischecked => ischected;

  checkbox1() {
    ischected = !ischected;
    notifyListeners();
  }

//add cart
  bool _isTrue = true;
  var _count = 1;
  get isTrue => _isTrue;

  get count => _count;
  incriment() {
    _count++;
    notifyListeners();
  }

  decrement() {
    _count--;
    notifyListeners();
  }

  isfalse() {
    _isTrue = false;
    notifyListeners();
  }
}