import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/Splash.dart';
import 'package:weather_app/services/data_handler.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(ChangeNotifierProvider(
    create: (context) => AppData(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}
