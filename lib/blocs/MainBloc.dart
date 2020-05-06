
import 'package:bloc/bloc.dart';
import 'package:corona_details/usecases/MainUseCases.dart';
import 'package:corona_details/blocs/events/MainEvents.dart';
import 'package:corona_details/blocs/states/MainStates.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends Bloc<MainEvents,MainStates> {
  final useCases = MainUseCases();
  final _subject = BehaviorSubject<MainStates>();

  BehaviorSubject<MainStates> get subject => _subject;

  @override
  MainStates get initialState => Idle();

  getCoronaDetailsFromApi() {
    var result = useCases.getCoronaDetails();
    result.listen((f) => _subject.sink.add(RetrieveCoronaDetailsState(f)));
  }

  @override
  Stream<MainStates> mapEventToState(MainEvents event) async* {
    switch (event) {
      case MainEvents.GetCoronaDetailsFromApi :
        getCoronaDetailsFromApi();
        break;

      case MainEvents.Idle :
        break;
    }

    dispose() {
      _subject.close();
    }
  }
}