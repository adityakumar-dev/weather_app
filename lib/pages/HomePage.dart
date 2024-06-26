// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/AppPallate.dart';
import 'package:weather_app/pages/components/HomePageCom/animation_weather.dart';
import 'package:weather_app/pages/components/HomePageCom/weatheCom.dart';
import 'package:weather_app/pages/components/Home_app_bar.dart';
import 'package:weather_app/services/data_handler.dart';
import 'package:weather_app/services/getWeatherDescription.dart';

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
    var forecast = weatherProvider.weatherData['forecast'];
    bool is_day() => weatherRepoData['is_day'] == 1 ? true : false;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Home_App_Bar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
            child: SingleChildScrollView(
          child: Column(
            children: [
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
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: animation_Weather(
                    weatherRepo, is_day, weatheDesc, weatherRepoData),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "12 Hour's Forecast",
                    style: TextStyle(
                        color: AppPallate.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: List.generate(forecast.length, (index) {
                  return weatherForecastHour(weatherRepo, forecast[index]);
                }),
              )
            ],
          ),
        )),
      ),
    );
  }

  Container weatherForecastHour(bool weatherRepo(), var desc) {
    var data = getWeatherDescription(desc['weathercode']);
    bool is_day() => (desc['is_day']) == 1 ? true : false;
    String? str = weatherRepo()
        ? 'assets/lottie/error.json'
        : is_day()
            ? data['night']
            : data['day'];
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.3),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Lottie.asset(str!, height: 30, width: 30),
              Text(
                weatherRepo() ? 'loading...' : "${desc['temperature']}C",
                style: const TextStyle(
                    color: AppPallate.white, fontWeight: FontWeight.bold),
              ),
              Text(
                weatherRepo() ? 'loading...' : desc['time'],
                style: const TextStyle(
                  color: AppPallate.white,
                ),
              ),
            ],
          ),
          WeatherComp('assets/images/svg/wind-svg.svg', 'wind Speed',
              weatherRepo() ? 'loading...' : '${desc['wind-speed']}km/h'),
          WeatherComp('assets/images/svg/moisture-svg.svg', 'wind Speed',
              weatherRepo() ? 'loading...' : '${desc['humidity']}%'),
          WeatherComp('assets/images/svg/cloud-svg.svg', 'Cloud',
              weatherRepo() ? 'loading...' : '${desc['cloud']}%'),
        ],
      ),
    );
  }
}
