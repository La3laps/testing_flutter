class WeatherData {
  final double temperature;
  final double windSpeed;
  final int humidity;
  final String date;

  WeatherData({
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.date,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    // Find the first date key like "2025-09-02 15:00:00"
    final nowKey =
        json.keys.firstWhere((k) => k.contains("202"), orElse: () => '');

    if (nowKey.isEmpty || json[nowKey] == null) {
      throw Exception("No valid weather data found");
    }

    final data = json[nowKey];

    return WeatherData(
      temperature: (data["temperature"]?["2m"] ?? 0).toDouble(),
      windSpeed: (data["vent_moyen"]?["10m"] ?? 0).toDouble(),
      humidity: (data["humidite"]?["2m"] ?? 0).toInt(),
      date: nowKey,
    );
  }
}
