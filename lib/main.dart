import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExchangeRateScreen(),
    );
  }
}

class ExchangeRateScreen extends StatelessWidget {
  final List<Map<String, String>> banks = [
    {'name': 'CBE', 'buying': '119.5', 'selling': '135.2'},
    {'name': 'DASHEN', 'buying': '119.5', 'selling': '135.2'},
    {'name': 'AWASH', 'buying': '119.5', 'selling': '135.2'},
    {'name': 'ABYSSIN.', 'buying': '119.5', 'selling': '135.2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Today Exchange Rate",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Currency buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currencyButton("USD", true),
                  _currencyButton("EURO"),
                  _currencyButton("GBP"),
                  _currencyButton("AED"),
                  _currencyButton("YUAN"),
                ],
              ),
              SizedBox(height: 16),

              // Table header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _headerText("BUYING"),
                  _headerText("SELLING"),
                  _headerText("CHANGE"),
                ],
              ),
              SizedBox(height: 8),

              // Bank data rows
              for (var bank in banks) _bankRow(bank),
            ],
          ),
        ),
      ),
    );
  }

  Widget _currencyButton(String text, [bool selected = false]) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: selected ? Colors.purple[300] : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _headerText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }Widget _bankRow(Map<String, String> bank) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bank name
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              bank['name']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Buying rate
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[300],
            child: Text(bank['buying']!),
          ),
          // Selling rate
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[300],
            child: Text(bank['selling']!),
          ),
          // Change indicator (dummy icon)
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[300],
            child: Icon(Icons.show_chart, size: 16),
          ),
        ],
      ),
    );
  }
}