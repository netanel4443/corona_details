
import 'package:corona_details/data/CoronaDetailsData.dart';
import 'package:corona_details/network/CoronaApi.dart';

class MainUseCases{
  final repo=CoronaApi();

  Stream<Set<CoronaDetailsData>> getCoronaDetails(){
    return Stream.fromFuture(repo.getCoronaDetails());
  }
}