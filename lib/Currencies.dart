class Currencies{
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final num circulatingSupply;
  final int errorCode;
  final num totalSupply;
  final num maxSupply;
  final DateTime lastUpdated;


  Currencies (
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

  factory Currencies.fromjson(Map<String,dynamic> json){
    return Currencies(
      id: json['data']['id'],
      name: json['data']['name'],
      symbol: json['data']['symbol'],
      slug: json['data']['slug'],
      circulatingSupply:json['data']['circulating_supply'] ,
      maxSupply: json['data']['max_supply'],
      totalSupply: json['data']['total_supply'],
      lastUpdated: json['data']['last_updated'],
      errorCode: json['status']['error_code']
    );
  }
}