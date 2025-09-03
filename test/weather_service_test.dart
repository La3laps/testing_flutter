import 'package:flutter_test/flutter_test.dart';
import 'package:testing_flutter/services/weather_service.dart';

void main() {
  test('WeatherService retourn des keys de type timestamp', () async {
    final service = WeatherService();
    final data = await service.fetchWeather();

    expect(data, isNotNull);
    expect(
      data!.keys.any((k) => k.contains("202")),
      isTrue,
      reason: 'Au moins une key de type timestamp (e.g. 2025-09-03 14:00:00)',
    );
  });
}
