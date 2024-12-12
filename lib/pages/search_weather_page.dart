import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:simple_weather_app/services/weather_service.dart';
import 'package:simple_weather_app/widgets/display_weather.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  State<SearchWeatherPage> createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "");
  Weather? _weather;
  String? _errorStatus;
  final TextEditingController _controller = TextEditingController();

  void _searchWeather() async {
    final city = _controller.text.trim();
    if (city.isEmpty) {
      setState(() {
        _errorStatus = "Please enter city name";
      });
      return;
    }
    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
        _errorStatus = null;
      });
    } catch (e) {
      setState(() {
        _errorStatus = "Colud not find weather data for $city";
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Weather"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'City Name',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchWeather,
                  ),
                ),
                onSubmitted: (value) => _searchWeather(),
              ),
              const SizedBox(height: 10),
              _errorStatus != null
                  ? Text(
                      _errorStatus!,
                      style: const TextStyle(color: Colors.red),
                    )
                  : _weather != null
                      ? DisplayWeather(weather: _weather!)
                      : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
