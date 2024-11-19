class Weather {
  final String cityName;
  final double temparature;
  final String condition;
  final String descriptin;
  final double pressure;
  final double humidity;
  final double windspeed;

  Weather(
      {required this.cityName,
      required this.temparature,
      required this.condition,
      required this.descriptin,
      required this.pressure,
      required this.humidity,
      required this.windspeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"],
      temparature: json["main"]["temp"].toDouble(),
      condition: json["weather"][0]["main"],
      descriptin: json["weather"][0]["description"],
      pressure: json["main"]["pressure"].toDouble(),
      humidity: json["main"]["humidity"].toDouble(),
      windspeed: json["wind"]["speed"].toDouble(),
    );
  }
}
