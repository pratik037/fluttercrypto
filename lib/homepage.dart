import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Currency.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:cryptoflutter/currenciesModel.dart';
import 'apikey.dart' as api;
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

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

  TextStyle red = TextStyle(color: Colors.red, fontWeight: FontWeight.w400);
  TextStyle green = TextStyle(color: Colors.green, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    var crn = Provider.of<CurrenciesListModel>(context);
    return SplitColorBackground(
      headerColor: Colors.indigo,
      header: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'CryptoWorld',
            style: TextStyle(
              letterSpacing: 3,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          // SizedBox(height: 30,),
          Text(
            'All Crypto Currencies in one place',
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: crn.length == 0
          ? Center(
              child: PKCardListSkeleton(
              isBottomLinesActive: true,
              isCircularImage: true,
              length: 5,
            ))
          : LiquidPullToRefresh(
            color: Colors.indigo,
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
                                child: Image.network(api.symbolUrl +
                                    currency.id.toString() +
                                    ".png"),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              currency.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.indigo),
                            ),
                          ),
                          subtitle: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 4, 4, 8),
                                      child: Text(
                                        "Price: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(crn.currencies[index].price
                                        .toStringAsFixed(2)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Icon(
                                        GroovinMaterialIcons.chart_line,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                    Text("1h: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(
                                      crn.currencies[index].percentChange1
                                              .toStringAsFixed(3) +
                                          "%",
                                      style:
                                          crn.currencies[index].percentChange1 <
                                                  0
                                              ? red
                                              : green,
                                    ),
                                    Container(
                                      width: 10,
                                      alignment: Alignment.center,
                                      child: Text("|", style: TextStyle(fontWeight: FontWeight.bold,)),
                                    ),
                                    Text("24h: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(
                                      crn.currencies[index].percentChange24
                                              .toStringAsFixed(3) +
                                          "%",
                                      style: crn.currencies[index]
                                                  .percentChange24 <
                                              0
                                          ? red
                                          : green,
                                    ),
                                    Container(
                                      width: 10,
                                      alignment: Alignment.center,
                                      child: Text("|", style: TextStyle(fontWeight: FontWeight.bold,)),
                                    ),
                                    Text("7d: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(
                                      crn.currencies[index].percentChange7
                                              .toStringAsFixed(3) +
                                          "%",
                                      style:
                                          crn.currencies[index].percentChange7 <
                                                  0
                                              ? red
                                              : green,
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