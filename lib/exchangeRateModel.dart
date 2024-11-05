import 'dart:convert';
import 'package:http/http.dart' as http;

// Model to handle exchange rate data
class ExchangeRateModel {
  final String token;

  ExchangeRateModel({required this.token});

  static const String liveUrl = "http://10.10.10.231:5000/v1";

  Future<String?> login() async {
    final auth = {
      "password": "test123",
      "email": "test3@wisetech.et"
    };

    final response = await http.post(
      Uri.parse('$liveUrl/users/login'),
      body: json.encode(auth),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token'];
    } else {
      return null;
    }
  }

  Future<List<dynamic>> fetchExchangeRates() async {
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
        'Authorization': token,
      },
      body: json.encode(auth),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load exchange rates");
    }
  }

  Future<List<dynamic>> fetchBestExchangeRates() async {
    final response = await http.get(
      Uri.parse('$liveUrl/forex/best'),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load best exchange rates");
    }
  }
}
