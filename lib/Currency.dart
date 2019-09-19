class Currency {
  int id;
  String name;
  double price;
  double percentChange1;
  double percentChange24;
  double percentChange7;
  double marketCap;
  String lastUpdated;

  Currency(
    this.price,
    this.percentChange1,
    this.percentChange24,
    this.percentChange7,
    this.marketCap, 
    this.id,
    this.name,
    this.lastUpdated,
  );

  Currency.fromMap(Map currencyMap){
    this.id = currencyMap['id'];
    this.price= currencyMap['quote']['INR']['price'];
    this.percentChange1 = currencyMap['quote']['INR']['percent_change_1h'];
    this.percentChange24 = currencyMap['quote']['INR']['percent_change_24h'];
    this.percentChange7 = currencyMap['quote']['INR']['percent_change_7d'];
    this.marketCap =  currencyMap['quote']['INR']['market_cap'];
    this.lastUpdated = currencyMap['quote']['INR']['last_updated'];
    this.name= currencyMap['name'];
  }
}