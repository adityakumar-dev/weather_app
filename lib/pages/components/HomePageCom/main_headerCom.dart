import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/AppPallate.dart';

Column WeatherComp(String path, String type, String text) {
  return Column(
    children: [
      SvgPicture.asset(
        path,
        height: 25,
        width: 25,
      ),
      Text(
        type,
        style: const TextStyle(
            color: AppPallate.white, fontSize: 13, fontWeight: FontWeight.w600),
      ),
      Text(
        text,
        style: const TextStyle(
            color: AppPallate.white, fontSize: 13, fontWeight: FontWeight.w400),
      )
    ],
  );
}

Row weatherComList(bool Function() weatherRepo, weatherRepoData) {
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
