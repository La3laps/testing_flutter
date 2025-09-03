import 'package:flutter_test/flutter_test.dart';
import 'package:testing_flutter/services/weather_service.dart';

void main() {
  test('WeatherService returns weather timestamp keys', () async {
    final service = WeatherService();
    final data = await service.fetchWeather();

    expect(data, isNotNull);
    expect(
      data!.keys.any((k) => k.contains("202")),
      isTrue,
      reason:
          'Expected at least one timestamp-like key (e.g. 2025-09-03 14:00:00)',
    );
  });
}
