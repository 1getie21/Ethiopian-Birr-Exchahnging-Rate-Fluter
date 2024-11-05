import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'exchangeRateModel.dart';

class ExchangeRateController extends ChangeNotifier {
  late ExchangeRateModel _model;

  List<dynamic> allBankExchangeRates = [];
  List<dynamic> allBanksBestExchangeRates = [];

  ExchangeRateController(String token) {
    _model = ExchangeRateModel(token: token);
  }

  Future<void> fetchExchangeRates() async {
    try {
      allBankExchangeRates = await _model.fetchExchangeRates();
      allBanksBestExchangeRates = await _model.fetchBestExchangeRates();
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  Future<void> login() async {
    final token = await _model.login();
    if (token != null) {
      _model = ExchangeRateModel(token: token);
      await fetchExchangeRates();
    } else {
      Fluttertoast.showToast(msg: "Login failed");
    }
  }
}
