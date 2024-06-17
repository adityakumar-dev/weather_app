// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/AppPallate.dart';
import 'package:weather_app/pages/components/Home_app_bar.dart';
import 'package:weather_app/services/data_handler.dart';
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
    WeatherLocationReport();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<AppData>(context);
    bool weatherRepo() => weatherProvider.weatherData['current'] == null;
    var weatherRepoData = weatherProvider.weatherData['current'];
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
                height: 10,
              ),
              const Text(
                "Today",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: AppPallate.white),
              ),
              const Text(
                "Tue, Dec 8",
                style: TextStyle(
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
                child: Column(
                  children: [
                    Lottie.asset('assets/lottie/cloud_snow.json',
                        height: 150, width: 150),
                    const Text(
                      "Rainy",
                      style: TextStyle(
                          color: AppPallate.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherRepo()
                              ? 'Loading..'
                              : weatherRepoData['temperature_2m'].toString(),
                          style: const TextStyle(
                              color: AppPallate.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
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
                    ),
                    Text(
                        weatherRepo()
                            ? 'loading..'
                            : "Feels like ${weatherRepoData['temperature_2m']}°C",
                        style: const TextStyle(
                            fontSize: 15, color: AppPallate.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WeatherComp(
                            'assets/images/svg/wind-svg.svg',
                            weatherRepo()
                                ? 'loading..'
                                : "${weatherRepoData['wind_speed_10m']}km/h"),
                        WeatherComp(
                            'assets/images/svg/moisture-svg.svg',
                            weatherRepo()
                                ? 'loading..'
                                : "${weatherRepoData['relative_humidity_2m']}%"),
                        WeatherComp(
                            'assets/images/svg/cloud-svg.svg',
                            weatherRepo()
                                ? 'loading..'
                                : "${weatherRepoData['cloud_cover']}%"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Column WeatherComp(String path, String text) {
    return Column(
      children: [
        SvgPicture.asset(
          path,
          height: 25,
          width: 25,
        ),
        Text(
          text,
          style: const TextStyle(
              color: AppPallate.white,
              fontSize: 13,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
