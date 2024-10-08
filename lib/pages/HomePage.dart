// ignore_for_file: non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/core/theme/AppPallate.dart';
import 'package:weather_app/pages/EditCityList.dart';
import 'package:weather_app/pages/components/HomePageCom/WeeklyForecast.dart';
import 'package:weather_app/pages/components/HomePageCom/animation_weather.dart';
import 'package:weather_app/pages/components/HomePageCom/day_weather_forecast.dart';
import 'package:weather_app/pages/components/Home_app_bar.dart';
import 'package:weather_app/services/AppBartittleHandler.dart';
import 'package:weather_app/services/city_list_handler.dart';
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
    final cityOfList = Provider.of<CityList>(context);
    final appBarIndex = Provider.of<AppBarHandler>(context);
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _refreshData() async {
      updateCityReport(context);

      await Future.delayed(const Duration(seconds: 2));
    }

    final pageController = PageController(initialPage: appBarIndex.getIndex);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Home_App_Bar(context),
      body: PageView.builder(
          controller: pageController,
          itemCount: cityOfList.listCity.length,
          onPageChanged: (index) {
            setState(() {
              appBarIndex.setIndex(index);
            });
          },
          itemBuilder: (context, index) {
            final weatherProvider = cityOfList.listCity[index];
            bool weatherRepo() => weatherProvider['current'] == null;
            var weatherRepoData = weatherProvider['current'];
            var weatheDesc = weatherProvider['weatherDesc'];
            var forecast = weatherProvider['forecast'];
            var weekly = weatherProvider['weekly'];
            var dates = weatherProvider['dates'];
            bool is_day() => weatherRepoData['is_day'] == 1 ? true : false;
            return GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  if (kDebugMode) {
                    print("swiped left");
                    print(pageController.page);
                  }
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                } else if (details.primaryVelocity! > 0) {
                  if (kDebugMode) {
                    print("swiped right");
                    print(pageController.page);
                  }
                  pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              onVerticalDragDown: (details) => {},
              child: Container(
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
                    child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SmoothPageIndicator(
                            effect: const WormEffect(
                                activeDotColor: Colors.white,
                                dotHeight: 10,
                                dotWidth: 10),
                            controller: pageController,
                            count: cityOfList.listCity.length),
                        const Text(
                          "Today",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: AppPallate.white),
                        ),
                        Text(
                          weatherRepo()
                              ? ' '
                              : DateFormat('yyyy-MM-dd HH:mm').format(
                                  DateTime.parse(weatherRepoData['time'])),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: animation_Weather(
                              weatherRepo, is_day, weatheDesc, weatherRepoData),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                weekly.length - 1,
                                (index) => getWeeklyWidget(context, weatherRepo,
                                    dates, weekly, index)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                            return weatherForecastHour(
                                weatherRepo, forecast[index]);
                          }),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Editcitylist()));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
