import 'package:flutter_test/flutter_test.dart';
import 'package:testing_flutter/services/weather_data.dart';

void main() {
  test('WeatherData parses correctly', () {
    const mockJson = {
      "2025-09-03 14:00:00": {
        "temperature": {"2m": 295.15},
        "vent_moyen": {"10m": 10.5},
        "humidite": {"2m": 60},
      }
    };

    final data = WeatherData.fromJson(mockJson);

    expect(data.temperature, 295.15);
    expect(data.windSpeed, 10.5);
    expect(data.humidity, 60);
    expect(data.date, "2025-09-03 14:00:00");
  });
}
