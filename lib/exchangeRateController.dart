import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'exchangeRateModel.dart';

class ExchangeRateController extends ChangeNotifier {
  List<dynamic> allBankExchangeRates = [];
  List<dynamic> filteredExchangeRates = [];
  String selectedCurrency = 'USD';

  late ExchangeRateModel _model;

  List<dynamic> allBanksBestExchangeRates = [];
  String? token;

  ExchangeRateController() {
    _model = ExchangeRateModel();
  }

  Future<void> fetchExchangeRatesTest() async {
    try {
      allBankExchangeRates = await _model.fetchBestExchangeRatesTest();
      filterExchangeRates();
    } catch (error) {
      print('Error fetching exchange rates: $error');
    }
  }

  Future<void> fetchExchangeRates() async {
    if (token == null) {
      Fluttertoast.showToast(msg: "Not logged in");
      return;
    }

    try {
      allBankExchangeRates = await _model.fetchExchangeRates(token!);
      allBanksBestExchangeRates = await _model.fetchBestExchangeRates(token!);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  Future<void> login() async {
    final token = await _model.login();
    if (token != null) {
      this.token = token; // Store the token in the controller
      notifyListeners();
      await fetchExchangeRates(); // Fetch exchange rates after login
    } else {
      Fluttertoast.showToast(msg: "Login failed");
    }
  }

  void filterExchangeRates() {
    filteredExchangeRates = [];
    for (var bank in allBankExchangeRates) {
      var rates = bank['rate'] ?? []; // Ensure 'rate' is not null
      var bankName = bank['bankName'] ?? 'Unknown Bank'; // Updated field name

      // Debugging: Check the actual bank name being processed
      print('Processing bank: $bankName');

      var filteredRates =
          rates.where((rate) => rate['base'] == selectedCurrency).toList();

      if (filteredRates.isNotEmpty) {
        filteredExchangeRates.add({
          'bank': bankName, // Use the updated key here
          'rates': filteredRates,
        });
      }
    }
    notifyListeners();
  }

  // Update selected currency and re-filter
  void updateSelectedCurrency(String currency) {
    selectedCurrency = currency;
    filterExchangeRates();
  }
}
