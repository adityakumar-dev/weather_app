import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/extraGlobalVariable.dart';
import 'package:weather_app/services/getWeatherDescription.dart';

class AppData extends ChangeNotifier {
  Map<String, dynamic> _data = {};
  get weatherData => _data;

  Future<void> updateDataList(
      Map<String, dynamic> test, BuildContext context) async {
    _data = test;
    _data['weatherDesc'] =
        getWeatherDescription(test['current']['weather_code']);
    _data['current']['date'] = getTime(test['current']['time'], context);

    var convertedTime = [];
    for (var value in _data['hourly']['time']) {
      convertedTime.add(getTime(value, context));
    }

    _data['hourly']['time'] = convertedTime;
    _data['forecast'] = hourlyForecast(context);

    weeklyForecast();

    if (kDebugMode) {}
    notifyListeners();
  }

  String getTime(String isoTime, context) {
    final extraData = Provider.of<extraVariable>(context, listen: false);
    try {
      DateTime dateTime = DateTime.parse(isoTime).add(extraData.duration);
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

      return formattedDate;
    } catch (e) {
      if (kDebugMode) {}
      return '';
    }
  }

  List<Map<String, dynamic>> hourlyForecast(BuildContext context) {
    final dt1 = DateTime.parse(getTime(_data['current']['time'], context));
    final forecastTimeStamps = <Map<String, dynamic>>[];

    for (int i = 0;
        i < _data['hourly']['time'].length && forecastTimeStamps.length < 12;
        i++) {
      final dt2 = DateTime.parse(_data['hourly']['time'][i]);
      if (dt1.compareTo(dt2) <= 0) {
        forecastTimeStamps.add({
          "temperature": _data['hourly']['temperature_2m'][i].toString(),
          "time": _data['hourly']['time'][i].split(' ')[1],
          "cloud": _data['hourly']['cloud_cover'][i].toString(),
          "humidity": _data['hourly']['relative_humidity_2m'][i].toString(),
          "wind-speed": _data['hourly']['wind_speed_10m'][i].toString(),
          "weathercode": _data['hourly']['weather_code'][i],
          "is_day": _data['hourly']['is_day'][i].toString(),
        });
      }
    }

    return forecastTimeStamps;
  }

  void weeklyForecast() {
    Map<String, Map<String, List<String>>> weeklyDate = {};
    List<dynamic> allDates = _data['hourly']['time'];
    for (int i = 0; i < allDates.length; i++) {
      DateTime temp = DateTime.parse(allDates[i]);
      String currentDate =
          '${temp.year}-${temp.month.toString().padLeft(2, '0')}-${temp.day.toString().padLeft(2, '0')}';
      String currentTime =
          '${temp.hour.toString().padLeft(2, '0')}-${temp.minute.toString().padLeft(2, '0')}';
      if (weeklyDate.containsKey(currentDate)) {
        weeklyDate[currentDate]!['time']!.add(currentTime);
        weeklyDate[currentDate]!['temperature']!
            .add(_data['hourly']['temperature_2m'][i].toString());
        weeklyDate[currentDate]!['humidity']!
            .add(_data['hourly']['relative_humidity_2m'][i].toString());
        weeklyDate[currentDate]!['wind_speed']!
            .add(_data['hourly']['wind_speed_10m'][i].toString());
        weeklyDate[currentDate]!['cloud_cover']!
            .add(_data['hourly']['cloud_cover'][i].toString());
        weeklyDate[currentDate]!['is_day']!
            .add(_data['hourly']['is_day'][i].toString());
        weeklyDate[currentDate]!['weather_code']!
            .add(_data['hourly']['weather_code'][i].toString());
      } else {
        weeklyDate[currentDate] = {
          'time': [currentTime],
          'temperature': [_data['hourly']['temperature_2m'][i].toString()],
          'humidity': [_data['hourly']['relative_humidity_2m'][i].toString()],
          'cloud_cover': [_data['hourly']['cloud_cover'][i].toString()],
          'is_day': [_data['hourly']['is_day'][i].toString()],
          'wind_speed': [_data['hourly']['wind_speed_10m'][i].toString()],
          'weather_code': [_data['hourly']['weather_code'][i].toString()],
          'day': [getWeekDay(temp.weekday)]
        };
      }
    }

//extract data for represent the day
    for (var entry in weeklyDate.entries) {
      String date = entry.key;
      //extracting weather code
      List<String>? weatherCodes = entry.value['weather_code'];

      Map<String, int> weatherCodeCount = {};
      // print(entry.value);
      for (String codes in weatherCodes!) {
        weatherCodeCount[codes] = (weatherCodeCount[codes] ?? 0) + 1;
      }
      String mostCommonCode = weatherCodeCount.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
      weeklyDate[date]!['w_code'] = [
        getWeatherDescription(int.parse(mostCommonCode))['day'] ??
            'assets/lottie/error.json'
      ];

      weeklyDate[date]!['w_desc'] = [
        getWeatherDescription(int.parse(mostCommonCode))['desc'] ?? 'Error!'
      ];

      //extracting temperature
      weeklyDate[date]!['t_code'] = getMaxMinValue(entry, 'temperature');
      weeklyDate[date]!['c_cover'] = getMaxMinValue(entry, 'cloud_cover');
      weeklyDate[date]!['w_speed'] = getMaxMinValue(entry, 'wind_speed');
      weeklyDate[date]!['h_code'] = getMaxMinValue(entry, 'humidity');
    }
    List date = weeklyDate.keys.toList();

    List<Map<String, List<String>>> dateTemp = weeklyDate.values.toList();
    _data['weekly'] = dateTemp;
    _data['dates'] = date;

    print(_data['weekly'][0]['time'].length);
  }

  List<String> getMaxMinValue(
      MapEntry<String, Map<String, List<String>>> entry, String str) {
    return [
      entry.value[str]!
          .reduce((a, b) => double.parse(a) > double.parse(b) ? a : b),
      entry.value[str]!
          .reduce((a, b) => double.parse(a) < double.parse(b) ? a : b)
    ];
  }

  String getWeekDay(int num) {
    switch (num) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
    }
    return "Error!";
  }
}
