import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/services/city_list_handler.dart';
import 'package:weather_app/services/weather_api_handler.dart';

class CustomSearchDelegate extends SearchDelegate {
  final String api = "pk.6f57dd82c8770e242c9e474af9cfa30f";
  List<dynamic> dataWithCoord = [];

  Future<List<Map<String, dynamic>>> fetchCities(String query) async {
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
      future: fetchCities(query),
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
                    await weatherCityReport(double.parse(city['lat']),
                        double.parse(city['lon']), placeName, context, -1);
                  } catch (e) {
                    print(e.toString());
                  }
                  close(context, place);
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
        ? const Center(child: Text("Search for a city"))
        : FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchCities(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
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
