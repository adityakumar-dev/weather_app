import 'package:flutter/material.dart';

import '../../../services/data_handler.dart';

RichText appBar_title(AppData weatherProvider) {
  return RichText(
    text: TextSpan(
      text: weatherProvider.weatherData['place'] == null
          ? 'Loading City..'
          : weatherProvider.weatherData['place'] + ', ',
      style: const TextStyle(
          color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 20),
      children: [
        TextSpan(
            text: weatherProvider.weatherData['place'] == null
                ? 'Loading City..'
                : weatherProvider.weatherData['placeCon'],
            style: const TextStyle(color: Colors.white38, fontSize: 15))
      ],
    ),
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
  );
}
