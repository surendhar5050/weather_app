import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_based_news/models/weather_model.dart';
import 'package:weather_based_news/providers/weather_provider.dart';
import 'package:weather_based_news/screens/news_screen.dart';
import 'package:weather_based_news/services/location_services.dart';
import 'package:weather_based_news/utils/colors.dart';
import 'package:weather_based_news/widgets/temperature.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _selectedMetric = "Celsius";

  void _fetchWeatherData() async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

//  await LocationServices().getLocation();
    weatherProvider.getWeatherData(getUnits(_selectedMetric));
  }

  @override
  void initState() {
    _fetchWeatherData();
    super.initState();
  }

  String getUnits(String units) {
    switch (units) {
      case 'Celsius':
        return 'metric';

      case 'Fahrenheit':
        return 'imperial';

      default:
        return 'Celsius';
    }
  }

  String getWeatherAnimation(String? weather) {
    if (weather == null) {
      return 'assets/lotties/sunny.json';
    }
    switch (weather.toLowerCase()) {
      case 'mist':
      case 'haze':
        return 'assets/lotties/mist.json';
      case 'clouds':
      case 'somke':
      case 'dust':
      case 'fog':
        return 'assets/lotties/cloud.json';
      case 'thunderstorm':
        return 'assets/lotties/heavy_rain.json';
      case 'clear':
        return 'assets/lotties/sunny.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/lotties/sunny_rainy.json';
      default:
        return 'assets/lotties/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Weather', style: Theme.of(context).textTheme.headlineSmall,),
          actions: [
            TextButton.icon(
                style: ButtonStyle(
                iconColor: WidgetStatePropertyAll(AppColor.primaryColor)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsScreen(),
                    ));
              },
              label:  Text('News',style: TextStyle(
                color: AppColor.primaryColor
              ),),
              icon: const Icon(Icons.newspaper_rounded),
            )
          ],
        ),
        body: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            if (weatherProvider.weatherData == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 10)
                  .copyWith(top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              weatherProvider.weatherData!.city ?? 'City',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.location_on),
                          ],
                        ),
                        DropdownButton(
                          underline: Container(),
                          value: _selectedMetric,
                          items: ['Celsius', 'Fahrenheit']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedMetric = value!;
                              context
                                  .read<WeatherProvider>()
                                  .getWeatherData(getUnits(_selectedMetric));
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(weatherProvider.weatherData!.list[0].datetime!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                        alignment: Alignment.center,
                        // height: 200,
                        width: double.infinity,
                        child: Row(
                          children: [
                            LottieBuilder.asset(getWeatherAnimation(
                                weatherProvider.weatherData!.list[0].weather)),
                            Text(
                              '${weatherProvider.weatherData!.list[0].temp!
                                  .toStringAsFixed(2)}${_selectedMetric == 'Celsius' ? "°C" : "°F"}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )

                        //  Center(
                        //   child:
                        // ),
                        ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Temperature(
                          temp:
                              '${weatherProvider.weatherData!.list[0].highTemp!.toStringAsFixed(2)}${_selectedMetric == 'Celsius' ? "°C" : "°F"} ',
                          title: 'High Temperature',
                        ),
                        Temperature(
                          temp:
                              '${weatherProvider.weatherData!.list[0].lowTemp!.toStringAsFixed(2)}${_selectedMetric == 'Celsius' ? "°C" : "°F"} ',
                          title: 'Low Temperature',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 120, // specify a height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherProvider.todayweather.length,
                        itemBuilder: (context, index) {
                          var value = weatherProvider.todayweather[index];
                          return ForecastWidget(
                              value: value, selectedMetric: _selectedMetric);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Next 5 Days >>',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120, // specify a height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherProvider.forcastWeathers.length,
                        itemBuilder: (context, index) {
                          var value = weatherProvider.forcastWeathers[index];
                          return ForecastWidget(
                            istoday: false,
                            value: value,
                            selectedMetric: _selectedMetric,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ForecastWidget extends StatelessWidget {
  ForecastWidget({
    super.key,
    required this.value,
    required String selectedMetric,
    this.istoday = true,
  }) : _selectedMetric = selectedMetric;

  final WeatherModel value;
  final String _selectedMetric;

  bool istoday;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.primaryColor,
      ),
      height: 120,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            istoday ? value.time ?? '' : value.datetime ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '${value.temp!.toStringAsFixed(2)}${_selectedMetric == 'Celsius' ? "°C" : "°F"}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value.weather ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
