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

    var convertedTime = [];
    for (var value in _data['hourly']['time']) {
      convertedTime.add(getTime(value));
    }

    _data['hourly']['time'] = convertedTime;
    var dt1 = DateTime.parse(getTime(_data['current']['time']));
    int count = 0, tempCount = 0;
    var forecastTimeStamps = [];
    _data['hourly']['time'].forEach((value) {
      var tempdata = {
        "temperature": _data['hourly']['temperature_2m'][tempCount].toString(),
        "time": value,
        "cloud": _data['hourly']['cloud_cover'][tempCount].toString(),
        'humidity':
            _data['hourly']['relative_humidity_2m'][tempCount].toString(),
        "wind-speed": _data['hourly']['wind_speed_10m'][tempCount].toString(),
        "weathercode": _data['hourly']['weather_code'][tempCount],
        "is_day": _data['hourly']['is_day'][tempCount].toString(),
      };
      var tempvalue = value.toString().split(' ');
      tempdata['time'] = tempvalue[1];
      if (count < 12) {
        var dt2 = DateTime.parse(value);

        if (dt1.compareTo((dt2)) == 0) {
          forecastTimeStamps.add(tempdata);
          count++;
        } else if (dt1.compareTo(dt2) < 0) {
          forecastTimeStamps.add(tempdata);
          count++;
        }
      }
      tempCount++;
    });
    _data['forecast'] = forecastTimeStamps;

    if (kDebugMode) {
      print(_data['current']['time']);
      print(_data['forecast']);
    }
    notifyListeners();
  }

  String getTime(String isoTime) {
    try {
      DateTime dateTime = DateTime.parse(isoTime);
      Duration offset = const Duration(hours: 5, minutes: 30);
      dateTime = dateTime.add(offset);
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

      return formattedDate;
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing time: $e');
      }
      return '';
    }
  }
}
