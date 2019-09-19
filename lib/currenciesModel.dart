import 'package:cryptoflutter/Currency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'apikey.dart' as api;
import 'dart:convert';
import 'package:date_format/date_format.dart';

class CurrenciesListModel extends ChangeNotifier {
  List<Currency> currencies = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  

  Future fetchCurrencies() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&convert=INR',
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

  String getDate(String stamp){
    // var x = stamp.split("T");
    // print("Inside given Time");
    // print(formatDate(dateTime,[dd,'-',MM]));
    // print("Inside DateNow fn: ");
    // String now = formatDate(DateTime.now(), [dd,'-',MM]);
    // print(formatDate(DateTime.now(), [dd,'-',MM]));
    // print(given.compareTo(now));
    
    DateTime dateTime = DateTime.parse(stamp);
    String given = formatDate(dateTime,[dd,'-',MM[0]]);
    return given;
  }

  String getTime(String stamp){
    // var x = stamp.split("T");
    // var z = x[1].split(".");
    DateTime dateTime = DateTime.parse(stamp);
    String given = formatDate(dateTime, [hh,':',nn,' ',am]);
    String now = formatDate(DateTime.now(), [hh,':',nn,' ',am]);
    print(given.compareTo(now));
    // print("Inside given time");
    // print(formatDate(dateTime, [hh,':',nn,' ',am]));
    // print("Inside Time fn: ");
    // print(formatDate(DateTime.now(), [hh,':',nn,' ',am]));
    return given;
  }

  int get length => currencies.length;
}
