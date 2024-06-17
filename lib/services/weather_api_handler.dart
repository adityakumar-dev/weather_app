// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/data_handler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String _baseUrl = dotenv.get('WEATHER_BASE_URL');
final String _urlValues = dotenv.get('WEATHER_URL_VALUES');
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
