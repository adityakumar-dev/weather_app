import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_app/pages/components/extras/error_Dailog.dart';
import 'package:weather_app/services/weather_api_handler.dart';

class CustomSearchDelegate extends SearchDelegate {
  var api = dotenv.get("LOCATION_API");
  List<dynamic> dataWithCoord = [];
  bool isErrorShowed = false;
  Future<List<Map<String, dynamic>>> fetchCities(
      String query, BuildContext context) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await http.get(Uri.parse(
            'https://api.locationiq.com/v1/autocomplete.php?key=$api&q=$query&limit=5&dedupe=1'));
        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          dataWithCoord = data;
          return data.map((item) {
            return {
              'display_name': item['display_name'].toString(),
              'lat': item['lat'],
              'lon': item['lon'],
            };
          }).toList();
        } else {
          throw Exception("Failed to get city list");
        }
      } on SocketException catch (e) {
        throw Exception("No internet connection ${e.toString()}");
      }
    } else {
      Future.delayed(Duration.zero, () => getErrorDailog(context));
      throw Exception("No Internet connection ");
    }
  }

  @override
  String get searchFieldLabel => "Search City";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCities(query, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No results found"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final city = snapshot.data![index];
              final List placeName =
                  city['display_name'].toString().split(', ').toSet().toList();
              final place = placeName.join(' ');
              return ListTile(
                title: Text(place),
                onTap: () async {
                  try {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    if (placeName.length == 1) {
                      placeName.add(" ");
                    }
                    await weatherCityReport(
                      double.parse(city['lat']),
                      double.parse(city['lon']),
                      placeName,
                      context,
                    );
                  } catch (e) {
                    Future.delayed(Duration.zero, () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    });
                  }
                  Future.delayed(Duration.zero, () => close(context, place));
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? const Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 150,
              ),
              Text(
                "Search for a city",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ))
        : FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchCities(query, context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // getErrorDailog(context);

                return const Center(child: Text("Error: Unable To Fetch City"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No suggestions found"));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final city = snapshot.data![index];
                    final List placeName = city['display_name']
                        .toString()
                        .split(', ')
                        .toSet()
                        .toList();
                    final place = placeName.join(', ');
                    return ListTile(
                      trailing: GestureDetector(
                        child: const Icon(Icons.call_made),
                        onTap: () {
                          query = place;
                        },
                      ),
                      title: GestureDetector(
                        onTap: () {
                          query = place;
                          showResults(context);
                        },
                        child: Text(place),
                      ),
                      onTap: () {
                        showResults(context);
                      },
                    );
                  },
                );
              }
            },
          );
  }
}
