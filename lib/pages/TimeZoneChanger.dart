import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/AppPallate.dart';
import 'package:weather_app/services/extraGlobalVariable.dart';

class TimeZonechanger extends StatefulWidget {
  const TimeZonechanger({super.key});

  @override
  State<TimeZonechanger> createState() => _TimeZonechangerState();
}

class _TimeZonechangerState extends State<TimeZonechanger> {
  @override
  Widget build(BuildContext context) {
    final extradata = Provider.of<extraVariable>(context, listen: false);

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
        title: const Text(
          "Change TimeZone",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
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
        padding: const EdgeInsets.only(top: 80, bottom: 10, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
              children: List.generate(extraVariable.timeZones.length, (index) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(255, 255, 255, 0.3)),
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: "${extraVariable.timeZones[index]['zones']}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Radio(
                      value: extraVariable.timeZones[index]['offset'],
                      activeColor: Colors.white,
                      groupValue: extradata.currentOffset,
                      onChanged: (value) async {
                        showDialog(
                            context: context,
                            builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ));

                        await extradata
                            .updateDuration(value, context)
                            .then((_) {
                          Navigator.of(context).pop();
                        });
                      })
                ],
              ),
            );
          })),
        ),
      ),
    );
  }
}
