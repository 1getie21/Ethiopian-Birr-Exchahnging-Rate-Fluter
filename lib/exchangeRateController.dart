import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'exchangeRateModel.dart';

class ExchangeRateController extends ChangeNotifier {
  late ExchangeRateModel _model;
  List<dynamic> allBankExchangeRates = [];
  List<dynamic> filteredExchangeRates = [];
  List<dynamic> allBanksBestExchangeRates = [];
  String? token;

  String selectedCurrency = 'USD'; // Default selected currency

  ExchangeRateController() {
    _model = ExchangeRateModel();
  }

  // Login method
  Future<void> login() async {
    final token = await _model.login();
    if (token != null) {
      this.token = token;
      notifyListeners();
      await fetchExchangeRates();  // Fetch all exchange rates after login
    } else {
      Fluttertoast.showToast(msg: "Login failed");
    }
  }

  // Fetch all exchange rates initially
  Future<void> fetchExchangeRates() async {
    if (token == null) {
      Fluttertoast.showToast(msg: "Not logged in");
      return;
    }

    try {
      allBankExchangeRates = await _model.fetchExchangeRates(token!);
      filterExchangeRates();  // Filter initially based on default currency
      allBanksBestExchangeRates = await _model.fetchBestExchangeRates(token!);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  // Filter exchange rates based on the selected currency
  void filterExchangeRates() {
    filteredExchangeRates = allBankExchangeRates.where((rate) {
      return rate['currency'] == selectedCurrency;
    }).toList();
    notifyListeners();
  }

  // Update selected currency and re-filter
  void updateSelectedCurrency(String currency) {
    selectedCurrency = currency;
    filterExchangeRates();
  }
}
