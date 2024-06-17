import 'package:flutter/material.dart';

import '../../../core/theme/AppPallate.dart';

Row Temperature_subtt(bool weatherRepo(), weatherRepoData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        weatherRepo()
            ? 'Loading..'
            : weatherRepoData['temperature_2m'].toString(),
        style: const TextStyle(
            color: AppPallate.white, fontWeight: FontWeight.bold, fontSize: 50),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          weatherRepo() ? '' : "°C",
          style: const TextStyle(
              color: AppPallate.white,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
      ),
    ],
  );
}
