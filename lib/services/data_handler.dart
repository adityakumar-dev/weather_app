import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

class AppData extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  get weatherData => _data;
  void updateDataList(Map<String, dynamic> test) async {
    _data = test;

    print(_data);
    notifyListeners();
  }
}
