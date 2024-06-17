// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/data_handler.dart';
import 'package:weather_app/services/location_handler.dart';
import 'package:http/http.dart' as http;

var current = [
  Current.is_day,
  Current.snowfall,
  Current.rain,
  Current.relative_humidity_2m,
  Current.apparent_temperature,
  Current.wind_speed_10m,
  Current.cloud_cover,
];
Future<List<dynamic>> WeatherLocationReport() async {
  try {
    Position position = await determinePosition();

    print("lat : ${position.latitude} lan : ${position.longitude}");

    // var result = await weather.raw_request(current: current);

    return [];
  } catch (e) {}
  return [];
}

const String _baseUrl = "https://api.open-meteo.com/v1/forecast";
const String _urlValues =
    "&current=temperature_2m,wind_speed_10m,cloud_cover,relative_humidity_2m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m,cloud_cover";
Future<void> weatherCityReport(double latitude, double longitude,
    List placeName, BuildContext context) async {
  var weather = await http.get(Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude$_urlValues'));

  var result = jsonDecode(weather.body);
  result['place'] = placeName[0];
  result['placeCon'] = placeName[1];
  Future.delayed(Duration.zero, () {
    final weatherData = Provider.of<AppData>(context, listen: false);
    weatherData.updateDataList(result);
  });
}
