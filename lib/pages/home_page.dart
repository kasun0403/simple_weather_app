import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:simple_weather_app/pages/search_weather_page.dart';
import 'package:simple_weather_app/services/weather_service.dart';
import 'package:simple_weather_app/widgets/display_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "");
  Weather? _weather;

  //method to fetch weather
  void fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherFromLocation();
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error from weather data $e");
    }
  }

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily Weather",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.light_mode),
          ),
        ],
      ),
      // body: DisplayWeather(weather: _weather),
      body: _weather != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DisplayWeather(weather: _weather!),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchWeatherPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "Search Weather",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
