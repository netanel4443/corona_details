import 'package:corona_details/blocs/MainBloc.dart';
import 'package:corona_details/blocs/events/MainEvents.dart';
import 'package:corona_details/blocs/states/MainStates.dart';
import 'package:corona_details/data/CoronaDetailsData.dart';
import 'package:corona_details/ui/DetailsListViewBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<MainBloc>(
        create: (context) => MainBloc(),
        child: MyApp(),
      ),
    ));

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MainStateTree createState() => MainStateTree();
}

class MainStateTree extends State<MyApp> {
  MainBloc bloc;
  Set<CoronaDetailsData> set = Set();
  CountriesDetailsScreen mainWidget;

  @override
  void initState() {
    super.initState();
    mainWidget = CountriesDetailsScreen(set);
    bloc = BlocProvider.of(context);
    bloc.add(MainEvents.Load);
    bloc.add(MainEvents.GetCoronaDetailsFromApi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Corona Details')),
      body: StreamBuilder(
        stream: bloc.subject,
        builder: (BuildContext context, AsyncSnapshot<MainStates> data) {
          if (data.hasData) {
            MainStates states = data.data;
            if (states is RetrieveCoronaDetailsState) {
              print("images ${states.list.length}");
              set.addAll(states.list);
              return mainWidget;
            } else if (states is ShowProgressBar) {
              return Center(child: CircularProgressIndicator());
            } else
              return mainWidget;
          } else
            return mainWidget;
        },
      ),
    );
  }
}


class CountriesDetailsScreen extends StatefulWidget {
  final Set<CoronaDetailsData> set;

  CountriesDetailsScreen(this.set);

  @override
  MainDesign createState() {
    print('times');
    return MainDesign(set);
  }
}

class MainDesign extends State<CountriesDetailsScreen> {
  Set set;
  MainBloc bloc;
  final controller = TextEditingController(text: "");
  final _compositeSubscription = CompositeSubscription();

  MainDesign(this.set);

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<MainBloc>(context);
    _compositeSubscription.add(bloc.startSubscribe().listen((item)=>
        setState(() {
          set.clear();
          set.addAll(item);
        })
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          maxLines: 1,
          controller: controller,
          focusNode: FocusNode(canRequestFocus: true),
          style: TextStyle(fontStyle: FontStyle.normal),
          onChanged: (String value) => bloc.initSearchStream(set, value),
        ),
        DetailsListViewBuilder().detailsList(set),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _compositeSubscription.clear();
  }
}
