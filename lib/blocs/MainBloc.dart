import 'package:bloc/bloc.dart';
import 'package:corona_details/data/CoronaDetailsData.dart';
import 'package:corona_details/usecases/MainUseCases.dart';
import 'package:corona_details/blocs/events/MainEvents.dart';
import 'package:corona_details/blocs/states/MainStates.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends Bloc<MainEvents, MainStates> {
  final useCases = MainUseCases();
  final _subject = BehaviorSubject<MainStates>();
  final countriesSearch = PublishSubject();
  Set<CoronaDetailsData> coronaDetailsSet=Set();
  BehaviorSubject<MainStates> get subject => _subject;


  Stream<Set<CoronaDetailsData>> startSubscribe() {
  return  countriesSearch
        .debounce((_) => TimerStream(true, Duration(milliseconds: 300)))
        .map((item) => (check(item)))
        .distinct();
        //.listen((item)=>{_test.add(item),});
  }
  MainBloc(){
   //  startSubscribe();
  }



  @override
  MainStates get initialState => Idle();

  getCoronaDetailsFromApi() {
    var result = useCases.getCoronaDetails();
    result.listen((set) =>getDetailsCountry(set));
  }

  showProgressBar() {
    _subject.sink.add(ShowProgressBar());
  }

  getDetailsCountry(Set<CoronaDetailsData>set) {
   coronaDetailsSet.addAll(set);
   _subject.sink.add(RetrieveCoronaDetailsState(set));
  }

  initSearchStream(Set<CoronaDetailsData> set, String string) {
    print(string);
    countriesSearch.add(string);
  }
  Set<CoronaDetailsData> check(String string) {
    Set<CoronaDetailsData> set=Set();
    coronaDetailsSet.forEach((f)=>{
      if (f.country.startsWith(string)) {
        print("yes"),
        set.add(f)
      }
    });
    return set;
  }


  @override
  Stream<MainStates> mapEventToState(MainEvents event) async* {
    switch (event) {
      case MainEvents.GetCoronaDetailsFromApi :
        getCoronaDetailsFromApi();
        break;

      case MainEvents.Idle :
        break;

      case MainEvents.Load:
        showProgressBar();
        break;

    }

    dispose() {
      _subject.close();
    }
  }
}

