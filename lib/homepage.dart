import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Currency.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:cryptoflutter/currenciesModel.dart';
import 'apikey.dart' as api;

class HomePage extends StatefulWidget {
  final CurrenciesListModel currenciesListModel;

  const HomePage({Key key, this.currenciesListModel}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrenciesListModel currenciesListModel;
  // List<Currency> currencies
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() {
    currenciesListModel = this.widget.currenciesListModel;
    super.initState();
  }

  TextStyle red = TextStyle(color: Colors.red);
  TextStyle green = TextStyle(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    var crn = Provider.of<CurrenciesListModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("CryptoWorld"),
        elevation: 3,
      ),
      body: crn.length == 0
          ? Center(
              child: PKCardListSkeleton(
              isBottomLinesActive: true,
              isCircularImage: true,
              length: 5,
            ))
          : LiquidPullToRefresh(
              showChildOpacityTransition: false,
              onRefresh: () async {
                await crn.fetchCurrencies();
              },
              child: ListView.builder(
                  itemCount: crn.length,
                  itemBuilder: (BuildContext context, int index) {
                    Currency currency = crn.currencies[index];

                    return Card(
                      elevation: 4,
                      child: ListTile(
                          //Currency Symbol
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                
                                backgroundColor: Colors.transparent,
                                child: Image.network(api.symbolUrl +currency.id.toString() + ".png"),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(currency.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.indigo
                              ),
                            ),
                          ),
                          subtitle: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8,4,4,8),
                                      child: Text("Price: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    Text(crn.currencies[index].price
                                        .toStringAsFixed(2)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.insert_chart, color: Colors.teal,),
                                    Text("1h: "),
                                    Text(
                                      crn.currencies[index].percentChange1.toStringAsFixed(3) + "%",
                                      style: crn.currencies[index].percentChange1 < 0 ? red : green,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("24h: "),
                                    Text(
                                      crn.currencies[index].percentChange24.toStringAsFixed(3) + "%",
                                      style: crn.currencies[index].percentChange24 < 0 ? red : green,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("7d: "),
                                    Text(
                                      crn.currencies[index].percentChange7.toStringAsFixed(3) + "%",
                                      style:crn.currencies[index].percentChange7 < 0 ? red : green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
            ),
    );
  }
}
