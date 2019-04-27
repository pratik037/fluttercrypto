class Currency{
  final int id;
  final String name;
  final String lastUpdated;
  final Map uSd;


  Currency (
    {
      this.id,
      this.name,  
      this.lastUpdated,
      this.uSd,
      });

  factory Currency.fromjson(Map<String,dynamic> json){
    return Currency(
      id: json['id'],
      name: json['name'],
      lastUpdated: json['last_updated'],
      uSd: json['USD'],

    );
  }
}