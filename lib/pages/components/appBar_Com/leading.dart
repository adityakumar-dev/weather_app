import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location_handler.dart';
import 'package:weather_app/services/weather_api_handler.dart';

import '../../../core/theme/AppPallate.dart';
import '../../../services/com/fetchCity.dart';

GestureDetector AppBarLeadingComponent(context) {
  return GestureDetector(
    onTap: () async {
      Position position = await determinePosition(context);
      try {
        var response = await fetchCity(position.latitude, position.longitude);
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var PlaceName =
              data['display_name'].toString().split(', ').toSet().toList();
          List place = [PlaceName[0], PlaceName[1]];
          weatherCityReport(
              position.latitude, position.longitude, place, context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    },
    child: const Icon(
      Icons.location_on,
      color: AppPallate.white,
    ),
  );
}
