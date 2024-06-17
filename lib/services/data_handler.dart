import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/getWeatherDescription.dart';

class AppData extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  get weatherData => _data;
  void updateDataList(Map<String, dynamic> test) async {
    _data = test;
    _data['weatherDesc'] =
        getWeatherDescription(test['current']['weather_code']);
    _data['current']['date'] = getTime(test['current']['time']);
    print(_data);
    notifyListeners();
  }

  String getTime(String isoTime) {
    DateTime dateTime = DateTime.parse(isoTime);
    Duration offest = Duration(hours: 5, minutes: 30);
    dateTime = dateTime.add(offest);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
}
