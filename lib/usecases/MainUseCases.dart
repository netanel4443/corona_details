
import 'package:corona_details/data/CoronaDetailsData.dart';
import 'package:corona_details/network/CoronaApi.dart';
import 'package:rxdart/rxdart.dart';

class MainUseCases{
  final repo=CoronaApi();

  Stream<Set<CoronaDetailsData>> getCoronaDetails(){
    return Stream.fromFuture(repo.getCoronaDetails());
  }

  Stream<Set<CoronaDetailsData>> searchForResults(Set<CoronaDetailsData> set) {

     
  }
}