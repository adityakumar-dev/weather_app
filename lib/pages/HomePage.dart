// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/AppPallate.dart';
import 'package:weather_app/pages/components/HomePageCom/animation_weather.dart';
import 'package:weather_app/pages/components/Home_app_bar.dart';
import 'package:weather_app/pages/components/appBar_Com/leading.dart';
import 'package:weather_app/services/com/fetchCity.dart';
import 'package:weather_app/services/data_handler.dart';
import 'package:weather_app/services/location_handler.dart';
import 'package:weather_app/services/weather_api_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<AppData>(context);
    bool weatherRepo() => weatherProvider.weatherData['current'] == null;
    var weatherRepoData = weatherProvider.weatherData['current'];
    var weatheDesc = weatherProvider.weatherData['weatherDesc'];
    bool is_day() => weatherRepoData['is_day'] == 1 ? true : false;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Home_App_Bar(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppPallate.gradient1,
              AppPallate.gradient2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Today",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: AppPallate.white),
              ),
              Text(
                weatherRepo() ? ' ' : weatherRepoData['date'],
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.white38),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 35),
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: animation_Weather(
                    weatherRepo, is_day, weatheDesc, weatherRepoData),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
