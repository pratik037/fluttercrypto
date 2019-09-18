class Currency {
  int id;
  String name;
  double price;
  double percentChange1;
  double percentChange24;
  double percentChange7;
  double marketCap;

  Currency(
    this.price,
    this.percentChange1,
    this.percentChange24,
    this.percentChange7,
    this.marketCap, 
    this.id,
    this.name,
  );

  Currency.fromMap(Map currencyMap){
    this.id = currencyMap['id'];
    this.price= currencyMap['quote']['USD']['price'];
    this.percentChange1 = currencyMap['quote']['USD']['percent_change_1h'];
    this.percentChange24 = currencyMap['quote']['USD']['percent_change_24h'];
    this.percentChange7 = currencyMap['quote']['USD']['percent_change_7d'];
    this.marketCap =  currencyMap['quote']['USD']['market_cap'];
    this.name= currencyMap['name'];
  }
}