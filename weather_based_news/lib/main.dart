import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_based_news/providers/news_provider.dart';
import 'package:weather_based_news/providers/weather_provider.dart';
import 'package:weather_based_news/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (context) => NewsScreenProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}
