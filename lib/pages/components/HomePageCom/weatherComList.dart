import 'package:flutter/material.dart';
import 'package:weather_app/pages/components/HomePageCom/weatheCom.dart';

Row weatherComList(bool weatherRepo(), weatherRepoData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      WeatherComp(
          'assets/images/svg/wind-svg.svg',
          'wind Speed',
          weatherRepo()
              ? 'loading..'
              : "${weatherRepoData['wind_speed_10m']}km/h"),
      WeatherComp('assets/images/svg/moisture-svg.svg', 'Humidity',
          weatherRepo() ? 'loading..' : "${weatherRepoData['cloud_cover']}%"),
      WeatherComp(
          'assets/images/svg/cloud-svg.svg',
          'Cloud',
          weatherRepo()
              ? 'loading..'
              : "${weatherRepoData['relative_humidity_2m']}%"),
    ],
  );
}
