import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exchangeRateController.dart';
import 'exchangeRateView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Exchange Rates',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ExchangeRateController()..login(), // Trigger login on startup
        child: const ExchangeRateView(),
      ),
    );
  }
}