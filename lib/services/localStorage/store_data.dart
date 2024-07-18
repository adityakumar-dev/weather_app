import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/city_list_handler.dart';

class StoreLocally {
  Future<void> getLocally(context) async {
    var box = await Hive.openBox('userData');
    var temp = box.get('city');
    final listOfCity = Provider.of<CityList>(context, listen: false);
    if (temp != null) {
      List<dynamic> rawData = box.get('city');
      List<Map<String, dynamic>> data = rawData
          .map(
              (item) => (item as Map<dynamic, dynamic>).cast<String, dynamic>())
          .toList();

      listOfCity.setCityList(data, context);
    } else {
      listOfCity.setCityList([], context);
    }
  }

  Future<void> setLocally(context) async {
    final listOfCity = Provider.of<CityList>(context, listen: false);
    var box = await Hive.openBox('userData');
    box.put('city', listOfCity.listCity);
  }
}

StoreLocally storeLocally = StoreLocally();
