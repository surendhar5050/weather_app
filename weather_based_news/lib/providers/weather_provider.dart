import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:weather_based_news/models/weather_model.dart';
import 'package:weather_based_news/services/location_services.dart';
import 'package:weather_based_news/services/weather_services.dart';

class WeatherProvider extends ChangeNotifier {
  String? location;
  WeatherData? weatherData;

  List<WeatherModel> todayweather = [];

  List<WeatherModel> forcastWeathers = [];

  final WeatherServices _weatherServices = WeatherServices();

  changeLocation(String newLocation) {
    location = newLocation;
    notifyListeners();
  }

  Future<void> getWeatherData(String units) async {
    weatherData=null;
    todayweather = [];
    forcastWeathers = [];
    var curlocation = await LocationServices().getLocation();

    weatherData = await _weatherServices.getWeather(
      curlocation.latitude.toStringAsFixed(2),
      curlocation.longitude.toStringAsFixed(2),
      units,
    );

    for (var element in weatherData!.list) {
  if (element.datetime == weatherData!.list[0].datetime) {
    todayweather.add(element);
  } else {
    if (forcastWeathers.isEmpty) {
      forcastWeathers.add(element);
    } else {
      bool isDuplicate = false;
      for (var forecast in forcastWeathers) {
        if (forecast.datetime == element.datetime) {
          isDuplicate = true;
          break;
        }
      }
      if (!isDuplicate) {
        forcastWeathers.add(element);
      }
    }
  }
}

    notifyListeners();
  }
}
