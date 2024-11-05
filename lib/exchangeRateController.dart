import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'exchangeRateModel.dart';

class ExchangeRateController extends ChangeNotifier {
  late ExchangeRateModel _model;

  List<dynamic> allBankExchangeRates = [];
  List<dynamic> allBanksBestExchangeRates = [];
  String? token;

  // Initialize with login method
  ExchangeRateController() {
    _model = ExchangeRateModel();
  }

  // Fetch the token and update the model
  Future<void> login() async {
    final token = await _model.login();
    if (token != null) {
      this.token = token;  // Store the token in the controller
      notifyListeners();
      await fetchExchangeRates();  // Fetch exchange rates after login
    } else {
      Fluttertoast.showToast(msg: "Login failed");
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
}