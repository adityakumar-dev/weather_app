import 'package:flutter/material.dart';
import 'package:weather_app/pages/HomePage.dart';
import 'package:weather_app/services/localStorage/store_data.dart';
import 'package:weather_app/services/weather_api_handler.dart';

class CityList extends ChangeNotifier {
  List<Map<String, dynamic>> _cityList = [];
  get listCity => _cityList;

  void updateCityList(int index, Map<String, dynamic> data) {
    _cityList[index] = data;
    notifyListeners();
  }

  Future<void> addCityList(
      Map<String, dynamic> data, BuildContext context) async {
    _cityList.add(data);
    await storeLocally.setLocally(context);

    print(_cityList[0]['current']);

    notifyListeners();
  }

  void deleteCityList(int index) {
    _cityList.removeAt(index);
    notifyListeners();
  }

  Future<void> setCityList(List<dynamic> data, context) async {
    // _cityList = data;
    if (data.isEmpty) {
      await weatherCityReport(
          28.70405920, 77.10249020, ['Delhi', 'India'], context, -1);
    } else {
      _cityList = data as List<Map<String, dynamic>>;
    }
    await storeLocally.setLocally(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

    // _cityList.add(weatherProvider.weatherData);
    notifyListeners();
  }
}
