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
  List<Currency> currencies = [];
  // List<Currency> currencies
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  Future getCurrencies() async {
    final response = await http.get(
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&convert=USD',
      headers: {
        "X-CMC_PRO_API_KEY": api.apikey,
      },
    );
    Map responseBody = json.decode(response.body);
    // print(responseBody);
    List data = responseBody['data'];
    // print(data);

    List<Currency> fetchedCurrencies = [];
    data.forEach((map) {
      //print(map['circulating_supply']);
      Map<String, dynamic> currencyMap = {
        "id": map['id'],
        "name": map['name'],
        "lastUpdated": map['last_updated'],
        "USD": {"price" : map['quote']['USD']['price'], 
        "percent_change_1h":map['quote']['USD']['percent_change_1h'],
        "percent_change_24h":map['quote']['USD']['percent_change_24h'],
        "percent_change_7d":map['quote']['USD']['percent_change_7d'],
        "market_cap": map['quote']['USD']['market_cap'],
         },
        
      };
      Currency currency = Currency.fromjson(currencyMap);
      fetchedCurrencies.add(currency);
    });

    // print(fetchedCurrencies.length);

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
      body: currencies.length == 0
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
                  itemBuilder: (_, int index) {
                    Currency currency = currencies[index];
                    
                    return Card(
                      elevation: 0,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text("\$"),
                        ),
                        title: Text(currency.name),
                        subtitle: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              
                              Row(
                                children: <Widget>[
                                  Text("Price: "),
                                  Text(currency.uSd['price']),
                                ],
                              ),


                              Row(
                                children: <Widget>[
                                  Text("% Changes: "),
                                  Text("1h: "),
                                  Text(currency.uSd['percent_change_1h'].toString()),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                    );
                  }),
            ),
    );
  }
}