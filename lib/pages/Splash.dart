import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/pages/HomePage.dart';
import 'package:weather_app/services/com/fetchCity.dart';
import 'package:weather_app/services/location_handler.dart';
import 'package:weather_app/services/weather_api_handler.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    fetchData(context);
    super.initState();
  }

  void fetchData(context) async {
    // Position position = await determinePosition(context);
    try {
      // var response = await fetchCity(position.latitude, position.longitude);
      // // if (response.statusCode == 200) {
      //   var data = jsonDecode(response.body);
      //   var PlaceName =
      //       data['display_name'].toString().split(', ').toSet().toList();
      //   List place = [PlaceName[0], PlaceName[1]];
      //   await weatherCityReport(
      //           position.latitude, position.longitude, place, context)
      //       .then((value) {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => const Home()));
      //   });
      // }
      await weatherCityReport(
              28.70405920, 77.10249020, ['Delhi', 'India'], context)
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      });
    } catch (e) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}
