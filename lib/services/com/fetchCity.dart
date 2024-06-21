import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future fetchCity(latitude, longitude) async {
  var api = dotenv.get('LOCATION_API');
  return await http.get(Uri.parse(
      'https://us1.locationiq.com/v1/reverse?key=$api&lat=${latitude}&lon=${longitude}&format=json&'));
}

