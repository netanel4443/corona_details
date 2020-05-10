
class CoronaDetailsData{

  String country="";
  int newCases=0;
  int totalCases=0;
  int recovered=0;
  int tests=0;
  CountryFlag countryFlag;
  CoronaDetailsData({this.country,this.newCases,this.totalCases,this.recovered,this.tests,this.countryFlag});

  factory CoronaDetailsData.fromJson(Map<String,dynamic> json){
    return CoronaDetailsData(
   country:     json['country'],
   newCases:    json['todayCases'],
   totalCases:  json['cases'],
   recovered:   json['recovered'],
   tests:       json['tests'],
   countryFlag: CountryFlag.fromJson(json['countryInfo'])
    );
  }
}
class CountryFlag{
  String flag="";

  CountryFlag(this.flag);
  factory CountryFlag.fromJson(Map<String,dynamic> json){
    return CountryFlag(
        json['flag']
    );
  }

}