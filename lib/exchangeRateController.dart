import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'exchangeRateModel.dart';

class ExchangeRateController extends ChangeNotifier {
  late ExchangeRateModel _model;

  List<dynamic> allBanksBestExchangeRates = [];
  String? token;

  ExchangeRateController() {
    _model = ExchangeRateModel();
  }

  // Login and fetch initial data
  Future<void> login() async {
    final token = await _model.login();
    if (token != null) {
      this.token = token;  // Store the token in the controller
      notifyListeners();
      await fetchExchangeRatesForCurrency('USD');  // Default to USD
    } else {
      Fluttertoast.showToast(msg: "Login failed");
    }
  }

  Future<void> fetchExchangeRatesForCurrency(String currency) async {
    if (token == null) {
      Fluttertoast.showToast(msg: "Not logged in");
      return;
    }

    try {
      allBanksBestExchangeRates = await _model.fetchExchangeRatesForCurrency(token!, currency);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }
}
