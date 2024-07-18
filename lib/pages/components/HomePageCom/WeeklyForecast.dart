import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/theme/AppPallate.dart';

Container getWeeklyWidget(
    context, bool Function() weatherRepo, dates, weekly, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    padding: const EdgeInsets.all(5),
    width: MediaQuery.of(context).size.width - 30,
    decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.3),
        borderRadius: BorderRadius.circular(20)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(weatherRepo() ? "error" : dates[index],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35)),
            Text(weatherRepo() ? "error" : weekly[index]['day'][0],
                style: const TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ],
        ),
        weatherWeeklyCom(weatherRepo, weekly, index)
      ],
    ),
  );
}

Row weatherWeeklyCom(bool Function() weatherRepo, weekly, int index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
              weatherRepo()
                  ? 'assets/lottie/error.json'
                  : weekly[index]['w_code'][0],
              height: 150,
              width: 150),
          Text(
            weatherRepo() ? "Loading..." : weekly[0]['w_desc'][0],
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            weatherRepo()
                ? "Loading..."
                : "${weekly[index]['t_code'][0]}°C - ${weekly[index]['t_code'][1]}°C",
            style: const TextStyle(
                color: AppPallate.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Column(
        children: [
          getWeeklyCom(weatherRepo, weekly, "wind-svg", "w_speed", "km/h",
              "Wind Speed", index),
          const SizedBox(
            height: 5,
          ),
          getWeeklyCom(weatherRepo, weekly, "moisture-svg", "h_code", "%",
              "Humidity", index),
          const SizedBox(
            height: 5,
          ),
          getWeeklyCom(
              weatherRepo, weekly, "cloud-svg", "c_cover", "%", "Cloud", index),
          const SizedBox(
            height: 5,
          ),
        ],
      )
    ],
  );
}

getWeeklyCom(bool Function() weatherRepo, dynamic weekly, String svg,
    String itemName, String standard, String desc, int index) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            'assets/images/svg/$svg.svg',
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            desc,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      Text(
        weatherRepo()
            ? 'error'
            : "${weekly[index][itemName][0]}$standard - ${weekly[index][itemName][1]}$standard",
        style: const TextStyle(color: AppPallate.white, fontSize: 16),
      ),
    ],
  );
}
