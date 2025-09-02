import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import '../services/weather_service.dart';
import '../services/weather_data.dart';

enum WeatherStatus { loading, error, loaded }

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _service = WeatherService();

  Map<String, dynamic>? _rawData;
  WeatherData? _parsedData;
  bool _isLoading = false;
  bool _showJson = false;

  Future<void> _loadWeather() async {
    setState(() {
      _isLoading = true;
      _parsedData = null;
    });

    final data = await _service.fetchWeather();

    setState(() {
      _rawData = data;
      if (data != null) {
        _parsedData = WeatherData.fromJson(data);
      }
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
      if (_parsedData == null) return WeatherStatus.error;
      return WeatherStatus.loaded;
    })();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Météo"),
        actions: [
          IconButton(
            icon: Icon(_showJson ? Icons.visibility_off : Icons.code),
            tooltip: "Afficher JSON",
            onPressed: () {
              setState(() => _showJson = !_showJson);
            },
          ),
        ],
      ),
      body: Center(
        child: () {
          switch (status) {
            case WeatherStatus.loading:
              return const CircularProgressIndicator();
            case WeatherStatus.error:
              return const Text("Erreur lors du chargement");
            case WeatherStatus.loaded:
              return _showJson
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: JsonViewer(_rawData!),
                    )
                  : _buildWeatherInfo();
          }
        }(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadWeather,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildWeatherInfo() {
    final data = _parsedData!;
    final celcius = data.temperature - 273.15;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Prévision pour : ${data.date}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          _buildWeatherCard(
              "🌡️ Température", "${celcius.toStringAsFixed(1)} °C"),
          _buildWeatherCard("💧 Humidité", "${data.humidity} %"),
          _buildWeatherCard("🌬️ Vent", "${data.windSpeed} km/h"),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.thermostat),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
