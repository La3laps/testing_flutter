import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _url =
      "http://www.infoclimat.fr/public-api/gfs/json?_ll=48.85341,2.3488&_auth=ABpVQg5wVnRXegE2VyEHLgJqATQPeVB3BHhVNgBlXiMAawJjBWVUMlA%2BUi8PIFdhVXgObQw3BzdWPVcvCnhXNgBqVTkOZVYxVzgBZFd4BywCLAFgDy9QdwRlVSwAal4jAGICYgVuVChQOFIzDyBXfFVnDmkMNgc5Vj1XMApiVzQAYFUyDnJWK1c%2BAWtXNQc1AmMBZg9hUGEENFU0ADhebwBjAmMFeFQ2UD9SNQ87V2ZVZA5nDDAHIFYqV0kKFFcpACNVcw44VnJXJQE2VzkHZw%3D%3D&_c=1f8fb9ac7703a47df99b494f51a3732e";

  Future<Map<String, dynamic>?> fetchWeather() async {
    final uri = Uri.parse(_url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print("Request failed with status: ${response.statusCode}.");
      return null;
    }
  }
}
