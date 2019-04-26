import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'Currencies.dart';
import 'apikey.dart' as api;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var currencies;
  final List<MaterialColor> _colors= [Colors.blue, Colors.indigo,Colors.red]; 


  @override
  Future initState() async {
    super.initState();
    currencies = await getCurrencies();
  }

  Future<Currencies> getCurrencies() async{
    final response = await http.get(
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest',
      headers: { "X-CMC_PRO_API_KEY" :api.apikey, ContentType(primaryType, subType),
       },
       
    );
    return json.decode(response.body);
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