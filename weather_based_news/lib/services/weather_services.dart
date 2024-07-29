import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_based_news/models/weather_model.dart';
import 'package:weather_based_news/utils/api_keys.dart';

class WeatherServices {
  final String baseUrl = "https://api.openweathermap.org/data/2.5/forecast";

  Future<WeatherData> getWeather(String lat,String lon, String units) async {
    try {

      print('$baseUrl?lat=$lat&lon=$lon&appid=${ApiKeys.weatherApikey}&units=$units');
      Uri url = Uri.parse(
          '$baseUrl?lat=$lat&lon=$lon&appid=${ApiKeys.weatherApikey}&units=$units');

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return WeatherData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {

   throw Exception(e.toString());
    }
  }
}
