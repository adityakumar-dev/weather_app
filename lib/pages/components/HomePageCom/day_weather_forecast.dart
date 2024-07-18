import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/theme/AppPallate.dart';
import 'package:weather_app/pages/components/HomePageCom/main_headerCom.dart';
import 'package:weather_app/services/getWeatherDescription.dart';

Container weatherForecastHour(bool Function() weatherRepo, var desc) {
  var data = getWeatherDescription(desc['weathercode']);
  // ignore: non_constant_identifier_names
  bool is_day() => (desc['is_day']) == 1 ? true : false;
  String? str = weatherRepo()
      ? 'assets/lottie/error.json'
      : is_day()
          ? data['night']
          : data['day'];
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
    decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.3),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Lottie.asset(str!, height: 30, width: 30),
            Text(
              weatherRepo() ? 'loading...' : "${desc['temperature']}C",
              style: const TextStyle(
                  color: AppPallate.white, fontWeight: FontWeight.bold),
            ),
            Text(
              weatherRepo() ? 'loading...' : desc['time'],
              style: const TextStyle(
                color: AppPallate.white,
              ),
            ),
          ],
        ),
        WeatherComp('assets/images/svg/wind-svg.svg', 'wind Speed',
            weatherRepo() ? 'loading...' : '${desc['wind-speed']}km/h'),
        WeatherComp('assets/images/svg/moisture-svg.svg', 'Humidity',
            weatherRepo() ? 'loading...' : '${desc['humidity']}%'),
        WeatherComp('assets/images/svg/cloud-svg.svg', 'Cloud',
            weatherRepo() ? 'loading...' : '${desc['cloud']}%'),
      ],
    ),
  );
}
