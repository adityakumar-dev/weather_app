import 'package:flutter/material.dart';

class AppBarHandler extends ChangeNotifier {
  int _index = 0;
  get getIndex => _index;

  setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
