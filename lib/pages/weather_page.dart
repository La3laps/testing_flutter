import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import '../services/weather_service.dart';

enum WeatherStatus { loading, error, loaded }

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _service = WeatherService();

  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;

  Future<void> _loadWeather() async {
    setState(() => _isLoading = true);

    final data = await _service.fetchWeather();

    setState(() {
      _weatherData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    final status = (() {
      if (_isLoading) return WeatherStatus.loading;
      if (_weatherData == null) return WeatherStatus.error;
      return WeatherStatus.loaded;
    })();

    return Scaffold(
      appBar: AppBar(title: const Text("Météo Infoclimat")),
      body: Center(
        child: () {
          switch (status) {
            case WeatherStatus.loading:
              return const CircularProgressIndicator();
            case WeatherStatus.error:
              return const Text("Erreur lors du chargement");
            case WeatherStatus.loaded:
              return SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: JsonViewer(_weatherData!),
              );
          }
        }(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _loadWeather,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
