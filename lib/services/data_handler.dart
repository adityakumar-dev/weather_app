import 'package:flutter/foundation.dart';
import 'package:weather_app/services/getWeatherDescription.dart';

class AppData extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  get weatherData => _data;
  void updateDataList(Map<String, dynamic> test) async {
    _data = test;
    _data['weatherDesc'] =
        getWeatherDescription(test['current']['weather_code']);
    print(
        'weather code is : ${getWeatherDescription(test['current']['weather_code'])}');
    print('weather code is : ${_data['current']['is_day']}');
    notifyListeners();
  }
}
