import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_flutter/pages/weather_page.dart';

void main() {
  testWidgets('WeatherPage montre le loading et le state erreur',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WeatherPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(
      find.textContaining('Erreur'),
      findsOneWidget,
      reason: 'Devrait dire erreur si data est nul',
    );
  });
}
