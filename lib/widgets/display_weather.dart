import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:simple_weather_app/utils/util_functions.dart';

class DisplayWeather extends StatelessWidget {
  final Weather weather;
  const DisplayWeather({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(
                  UtilFunctions()
                      .getWeatherAnimation(condition: weather.condition),
                  width: 400,
                  height: 400),
            ),
            Text(
              weather.cityName,
              style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${weather.temparature.toStringAsFixed(1)}°C",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
            ),
            Row(
              children: [
                Text(
                  weather.condition,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  weather.descriptin,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDetails("Presure", "${weather.pressure} hPa"),
                _buildWeatherDetails("Humidity", "${weather.humidity} %"),
                _buildWeatherDetails("Wind Speed", "${weather.windspeed} m/s"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetails(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.normal, color: Colors.grey),
        ),
      ],
    );
  }
}
