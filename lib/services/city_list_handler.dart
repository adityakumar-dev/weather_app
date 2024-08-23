import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/HomePage.dart';
import 'package:weather_app/services/AppBartittleHandler.dart';
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
    final appBarIndex = Provider.of<AppBarHandler>(context, listen: false);
    appBarIndex.setIndex(_cityList.length - 1);
    await storeLocally.setLocally(context);

    notifyListeners();
  }

  void deleteCityList(int index, BuildContext context) {
    _cityList.removeAt(index);
    final appBarIndex = Provider.of<AppBarHandler>(context, listen: false);
    appBarIndex.setIndex(_cityList.length - 1);
    storeLocally.setLocally(context);
    notifyListeners();
  }

  Future<void> setCityList(List<dynamic> data, context) async {
    // _cityList = data;
    if (data.isEmpty || data == []) {
      await weatherCityReport(
        28.70405920,
        77.10249020,
        ['Delhi', 'India'],
        context,
      );
    } else {
      _cityList = data as List<Map<String, dynamic>>;
    }
    await storeLocally.setLocally(context);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

    // _cityList.add(weatherProvider.weatherData);
    notifyListeners();
  }
}
