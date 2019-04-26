import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'Currency.dart';
import 'apikey.dart' as api;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var currencies;
  // List<Currency> currencies
  final List<MaterialColor> _colors= [Colors.blue, Colors.indigo,Colors.red]; 


  @override
  Future initState() async {
    super.initState();
    currencies = await getCurrencies();
  }

  Future<Currency> getCurrencies() async{
    final response = await http.get(
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=10&convert=USD',
      headers: { "X-CMC_PRO_API_KEY" :api.apikey,},
    );
    Map responseMap = json.decode(response.body);
    List<Map> data = responseMap['data'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CryptoCurrency"),

      ),
      body: _cryptoWidget(),
    );
  }


  Widget _cryptoWidget(){
    return Container(
      child: Flexible(
        child: ListView.builder(
          itemCount: 0,
          itemBuilder: (_,int index){

          },
        )
      ),
    );
  }
}