import 'package:cryptoflutter/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cryptoflutter/currenciesModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CurrenciesListModel _currenciesListModel;

  @override
  void initState() {
    _currenciesListModel = CurrenciesListModel();
    _currenciesListModel.fetchCurrencies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: "CryptoWorld",
        debugShowCheckedModeBanner: false,
        home: HomePage(currenciesListModel: _currenciesListModel,),
      ),
      providers: [
        ChangeNotifierProvider(
          builder: (BuildContext context) {
            return _currenciesListModel;
          },
        )
      ],
    );
  }
}
