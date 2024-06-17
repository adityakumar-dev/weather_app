// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/SearchPage.dart';

import '../../core/theme/AppPallate.dart';
import '../../services/data_handler.dart';

AppBar Home_App_Bar(context) {
  final weatherProvider = Provider.of<AppData>(context);
  print(weatherProvider.weatherData['place']);
  return AppBar(
    elevation: 0.0,
    backgroundColor: AppPallate.transparent,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          weatherProvider.weatherData['place'] == null
              ? 'Loading City..'
              : weatherProvider.weatherData['place'] + ', ',
          style: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          weatherProvider.weatherData['place'] == null
              ? 'Loading City..'
              : weatherProvider.weatherData['placeCon'],
          style: const TextStyle(color: Colors.white38, fontSize: 15),
        ),
      ],
    ),
    leading: const Icon(
      Icons.menu,
      color: AppPallate.white,
    ),
    actions: [
      GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: CustomSearchDelegate());
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 22.0),
          child: Icon(
            Icons.search_sharp,
            color: AppPallate.white,
            size: 30,
          ),
        ),
      ),
    ],
  );
}
