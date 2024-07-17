import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/AppPallate.dart';
import 'package:weather_app/pages/TimeZoneChanger.dart';
import 'package:weather_app/services/city_list_handler.dart';

class Editcitylist extends StatefulWidget {
  const Editcitylist({super.key});

  @override
  State<Editcitylist> createState() => _EditcitylistState();
}

class _EditcitylistState extends State<Editcitylist> {
  @override
  Widget build(BuildContext context) {
    final cityOfList = Provider.of<CityList>(context);
    var data = cityOfList.listCity;
    print(data[0]['current']['is_day']);
    bool isactive = cityOfList.listCity.length > 1 ? true : false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TimeZonechanger(),
                )),
            child: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          "Edit City",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: AppPallate.transparent,
      ),
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(top: 80, bottom: 10),
            child: Column(
              children: List.generate(
                cityOfList.listCity.length,
                (index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                                data[index]['current']['is_day'] == 1
                                    ? data[index]['weatherDesc']['day']
                                    : data[index]['weatherDesc']['night'],
                                height: 30,
                                width: 30),
                          ],
                        ),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                        text:
                                            "${cityOfList.listCity[index]['place']} , ${cityOfList.listCity[index]['placeCon']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${data[index]['current']['temperature_2m']}°C",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            if (cityOfList.listCity.length > 1) {
                              cityOfList.deleteCityList(index, context);

                              setState(() {
                                isactive = false;
                              });
                            } else {
                              setState(() {
                                isactive = true;
                              });
                            }
                          },
                          child: isactive
                              ? const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )
                              : const Icon(Icons.delete,
                                  color: Color.fromRGBO(255, 255, 255, 0.3)),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
