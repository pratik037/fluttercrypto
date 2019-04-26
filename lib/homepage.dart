import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'Currency.dart';
import 'apikey.dart' as api;
import 'package:pk_skeleton/pk_skeleton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Currency> currencies = null;
  // List<Currency> currencies
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  Future<List<Currency>> getCurrencies() async {
    final response = await http.get(
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=10&convert=USD',
      headers: {
        "X-CMC_PRO_API_KEY": api.apikey,
      },
    );
    Map responseBody = json.decode(response.body);
    // print(responseBody);
    List<Map> data = responseBody['data'];
    print(data);

    List<Currency> fetchedCurrencies = [];
    data.forEach((Map currencyMap) {
      Currency currency = Currency.fromjson(currencyMap);
      // print(currency);
      fetchedCurrencies.add(currency);
    });

    // debugPrint(fetchedCurrencies.toString());

    setState(() {
      currencies = fetchedCurrencies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CryptoCurrency"),
      ),
      body: currencies == null
          ? Center(
              child: PKCardListSkeleton(
              isBottomLinesActive: true,
              isCircularImage: true,
              length: 5,
            ))
          : RefreshIndicator(
              onRefresh: getCurrencies,
              child: ListView.builder(
                  itemCount: currencies.length,
                  itemBuilder: (_, int index) => Card(
                        elevation: 0,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text("\$"),
                          ),

                          // title: Text(currencies[index]["name"]),
                        ),
                      )),
            ),
    );
  }
}
