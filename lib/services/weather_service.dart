import 'dart:convert';
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/services/get_location_service.dart';

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService({required this.apiKey});
  //get the weather from the city name
  Future<Weather> getWeather(String cityName) async {
    try {
      final String url = "$BASE_URL/?q=$cityName&appid=$apiKey&units=metric";
      final responce = await http.get(Uri.parse(url));
      if (responce.statusCode == 200) {
        Weather weather = Weather.fromJson(json.decode(responce.body));
        return weather;
      } else {
        throw Exception("Field to load weather data ");
      }
    } catch (e) {
      print("error: $e");
      throw Exception("Field to load weather data ");
    }
  }

  //Get the weather from lat  and lon
  Future<Weather> getWeatherFromLatLon(double lat, double lon) async {
    try {
      final String url =
          "$BASE_URL?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
      final responce = await http.get(Uri.parse(url));
      if (responce.statusCode == 200) {
        final json = jsonDecode(responce.body);
        return Weather.fromJson(json);
      } else {
        throw Exception("Field to load weather data ");
      }
    } catch (e) {
      print("error: $e");
      throw Exception("Field to load weather data ");
    }
  }

  //Get the weather from current location
  Future<Weather> getWeatherFromLocation() async {
    final location = GetLocationService();
    final cityName = await location.getCityNameFromCurrentLocation();
    try {
      final String url = "$BASE_URL/?q=$cityName&appid=$apiKey&units=metric";
      final responce = await http.get(Uri.parse(url));
      print(responce.body);
      if (responce.statusCode == 200) {
        Weather weather = Weather.fromJson(json.decode(responce.body));
        return weather;
      } else {
        throw Exception("Field to load weather data ");
      }
    } catch (e) {
      print("error: $e");
      throw Exception("Field to load weather data ");
    }
  }
}
