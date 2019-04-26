class Currency{
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final num circulatingSupply;
  final int errorCode;
  final num totalSupply;
  final num maxSupply;
  final DateTime lastUpdated;


  Currency (
    {
      this.id,
      this.name, 
      this.symbol, 
      this.slug, 
      this.errorCode, 
      this.circulatingSupply, 
      this.lastUpdated,
      this.maxSupply,
      this.totalSupply
      });

  factory Currency.fromjson(Map<String,dynamic> json){
    return Currency(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      slug: json['slug'],
      circulatingSupply:json['circulating_supply'] ,
      maxSupply: json['max_supply'],
      totalSupply: json['total_supply'],
      lastUpdated: json['last_updated'],
      errorCode: json['error_code']
    );
  }
}