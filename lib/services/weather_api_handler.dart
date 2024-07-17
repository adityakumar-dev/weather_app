// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/city_list_handler.dart';
import 'package:weather_app/services/data_handler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String _baseUrl = dotenv.get('WEATHER_BASE_URL');
final String _urlValues = dotenv.get('WEATHER_URL_VALUES');
Future<void> weatherCityReport(
  double latitude,
  double longitude,
  List placeName,
  BuildContext context,
) async {
  var weather = await http.get(Uri.parse(
      '$_baseUrl?latitude=$latitude&longitude=$longitude$_urlValues'));
  if (weather.statusCode == 200) {
    var result = jsonDecode(weather.body);
    result['place'] = placeName[0];
    result['placeCon'] = placeName[1];

    Future.delayed(Duration.zero, () async {
      final weatherData = Provider.of<AppData>(context, listen: false);
      await weatherData.updateDataList(result, context);
      final cityOfList = Provider.of<CityList>(context, listen: false);

      await cityOfList.addCityList(weatherData.weatherData, context);
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Error : unable to get data code : ${weather.statusCode}")));
  }
}

Future<void> updateCityReport(BuildContext context) async {
  final cityOfList = Provider.of<CityList>(context, listen: false);
  for (int i = 0; i < cityOfList.listCity.length; i++) {
    List PlaceName = [];
    PlaceName.addAll(
        [cityOfList.listCity[i]['place'], cityOfList.listCity[i]['placeCon']]);

    var latitude = cityOfList.listCity[i]['latitude'];
    var longitude = cityOfList.listCity[i]['longitude'];

    var weather = await http.get(Uri.parse(
        '$_baseUrl?latitude=$latitude&longitude=$longitude$_urlValues'));
    if (weather.statusCode == 200) {
      var result = jsonDecode(weather.body);
      result['place'] = PlaceName[0];
      result['placeCon'] = PlaceName[1];
      Future.delayed(Duration.zero, () {
        final weatherData = Provider.of<AppData>(context, listen: false);
        weatherData.updateDataList(result, context);
        cityOfList.updateCityList(i, weatherData.weatherData);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Error : unable to get data code : ${weather.statusCode}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  // print(
  //     "${cityOfList.listCity[0]['place']} ${cityOfList.listCity[0]['placeCon']}");
}
