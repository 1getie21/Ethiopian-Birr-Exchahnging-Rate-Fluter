import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRateModel {
  static const String liveUrl = "http://10.10.10.231:5000/v1";
  static const String test = 'http://localhost:8080/rates';

  Future<String?> login() async {
    final auth = {"password": "test123", "email": "test3@wisetech.et"};

    final response = await http.post(
      Uri.parse('$liveUrl/users/login'),
      body: json.encode(auth),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token']; // Return the token
    } else {
      return null;
    }
  }

  // Fetch exchange rates using the dynamic token
  Future<List<dynamic>> fetchExchangeRates(String token) async {
    final auth = {
      "request": {
        "bank_id": ["all"],
        "from": ["all"],
        "to": "BIRR"
      }
    };

    final response = await http.post(
      Uri.parse('$liveUrl/forex/latest'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token, // Use the token dynamically
      },
      body: json.encode(auth),
    );

    if (response.statusCode == 200) {
      return json.decode(response as String);
    } else {
      throw Exception("Failed to load exchange rates");
    }
  }

  Future<List<dynamic>> fetchBestExchangeRates(String token) async {
    final response = await http.get(
      Uri.parse('$liveUrl/forex/best'),
      headers: {
        'Authorization': token, // Use the token dynamically
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load best exchange rates");
    }
  }

  Future<List<dynamic>> fetchBestExchangeRatesTest() async {
    final response = await http.get(Uri.parse(test));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load best exchange rates");
    }
  }
}
