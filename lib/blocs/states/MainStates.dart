
import 'package:corona_details/data/CoronaDetailsData.dart';

class MainStates{}

class Idle extends MainStates{}

class RetrieveCoronaDetailsState extends MainStates{
  Set<CoronaDetailsData> list;

  RetrieveCoronaDetailsState(this.list);
}
class ShowProgressBar extends MainStates{}

class RefreshList extends MainStates{
  Set<CoronaDetailsData> set=Set();
  RefreshList(this.set);
}