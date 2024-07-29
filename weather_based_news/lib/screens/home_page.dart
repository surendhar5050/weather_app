import 'package:flutter/material.dart';
import 'package:weather_based_news/screens/weather_screen.dart';
import 'package:weather_based_news/services/location_services.dart';
import 'package:weather_based_news/services/weather_services.dart';
import 'package:weather_based_news/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getPresmisson();
    super.initState();
  }

  getPresmisson() async {
    final LocationServices locationServices = LocationServices();
    await locationServices.getPresmisson();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton.icon(
            style: ButtonStyle(
                iconColor: WidgetStatePropertyAll(AppColor.primaryColor)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherScreen(),
                  ));
            },
            label: const Text('Get Started'),
            icon: const Icon(
              Icons.cloud,
            ),
          ),
        ),
      ),
    );
  }
}
