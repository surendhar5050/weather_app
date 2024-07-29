// class WeatherModel {
//   String? weather;
//   String? datetime;
//   double? temp;
//   double? highTemp;
//   double? lowTemp;
//   String? shortDay;

//   WeatherModel({
//     required this.weather,
//     required this.datetime,
//     required this.highTemp,
//     required this.lowTemp,
//     required this.temp,
//   });

//   factory WeatherModel.fromJson(Map<String, dynamic> json) {
//     return WeatherModel(
//       weather: json['weather'][0]['main'],
//       datetime: json['dt'],
//       highTemp: json['main']['temp_max'],
//       lowTemp: json['main']['temp_min'],
//       temp: json['main']['temp'],
//     );
//   }
// }
// To parse this JSON data, do
//
//     final weatherData = weatherDataFromJson(jsonString);

import 'dart:convert';

import 'package:weather_based_news/utils/time_stamp_convertion.dart';

WeatherData weatherDataFromJson(String str) =>
    WeatherData.fromJson(json.decode(str));

class WeatherData {
  int cnt;
  List<WeatherModel> list;
  String city;

  WeatherData({
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        cnt: json["cnt"],
        list: List<WeatherModel>.from(
            json["list"].map((x) => WeatherModel.fromJson(x))),
        city: json["city"]['name'],
      );
}

class WeatherModel {
  String? weather;
  String? datetime;
  num? temp;
  num? highTemp;
  num? lowTemp;
  String? shortDay;
  String? time;

  WeatherModel(
      {required this.shortDay,
      required this.weather,
      required this.datetime,
      required this.highTemp,
      required this.lowTemp,
      required this.temp,
      required this.time});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        weather: json['weather'][0]['main'],
        datetime: TimeStampConvertion.convertTimestamp(json['dt']),
        highTemp: json['main']['temp_max'],
        lowTemp: json['main']['temp_min'],
        temp: json['main']['temp'],
        shortDay: TimeStampConvertion.getShortDay(json['dt']),
        time: TimeStampConvertion.getTime(json['dt']));
  }
}
