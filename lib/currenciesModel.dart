import 'package:cryptoflutter/Currency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'apikey.dart' as api;
import 'dart:convert';

class CurrenciesListModel extends ChangeNotifier {
  List<Currency> currencies = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future fetchCurrencies() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&convert=USD',
      headers: {
        "X-CMC_PRO_API_KEY": api.apikey,
      },
    );

    Map responseBody = json.decode(response.body);
    List data = responseBody['data'];

    data.forEach((map) {
      Currency currency = Currency.fromMap(map);
      currencies.add(currency);
    });
    _isLoading = false;
    notifyListeners();
  }

  List<Currency> get allCurrencies => currencies;

  int get length => currencies.length;
}
