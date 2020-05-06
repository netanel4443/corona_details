import 'dart:collection';
import 'dart:convert';
import 'package:corona_details/data/CoronaDetailsData.dart';
import 'package:http/http.dart' as Http;

class CoronaApi {

  final baseUrl="https://disease.sh/v2/countries?yesterday=false&sort=cases";

  Future<Set<CoronaDetailsData>> getCoronaDetails() async{
    final response=await Http.get(baseUrl);

    if(response.statusCode==200){
      final body=response.body;
      List<dynamic> decode=jsonDecode(body);

      Set<CoronaDetailsData> data=
      decode.map((f)=>CoronaDetailsData.fromJson(f)).toSet();
      return data.toSet();
    }

  }
}