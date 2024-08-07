import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/pages/components/HomePageCom/temperature_subtt.dart';
import 'package:weather_app/pages/components/HomePageCom/main_headerCom.dart';
import '../../../core/theme/AppPallate.dart';

// ignore: non_constant_identifier_names
Column animation_Weather(bool Function() weatherRepo, bool Function() is_day,
    weatheDesc, weatherRepoData) {
  return Column(
    children: [
      Lottie.asset(
          weatherRepo()
              ? "assets/lottie/error.json"
              : is_day()
                  ? weatheDesc['day']
                  : weatheDesc['night'],
          height: 150,
          width: 150),
      Text(
        weatherRepo() ? '' : weatheDesc['desc'],
        style: const TextStyle(
            color: AppPallate.white, fontWeight: FontWeight.w400, fontSize: 20),
      ),
      Temperature_subtt(weatherRepo, weatherRepoData),
      Text(
          weatherRepo()
              ? 'loading..'
              : "Feels like ${weatherRepoData['temperature_2m']}°C",
          style: const TextStyle(fontSize: 15, color: AppPallate.white)),
      const SizedBox(
        height: 20,
      ),
      weatherComList(weatherRepo, weatherRepoData),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
