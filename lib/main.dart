import 'package:corona_details/blocs/MainBloc.dart';
import 'package:corona_details/blocs/events/MainEvents.dart';
import 'package:corona_details/blocs/states/MainStates.dart';
import 'package:corona_details/ui/DetailsListViewBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    bloc = BlocProvider.of(context);
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
              return CountriesDetailsScreen(states.list);
            } else if (states is ShowProgressBar)
              return Center(child: CircularProgressIndicator());
            else
              return Text("test");
          } else
            return Text("test no daata");
        },
      ),
    );
  }
}


class CountriesDetailsScreen extends StatelessWidget{
  final Set set;

  CountriesDetailsScreen(this.set);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          maxLines: 1,
          controller: TextEditingController(text:""),
          focusNode: FocusNode(canRequestFocus: true),
          style: TextStyle(fontStyle: FontStyle.normal),
        ),
        DetailsListViewBuilder().detailsList(set)
      ],
    );
  }
}

