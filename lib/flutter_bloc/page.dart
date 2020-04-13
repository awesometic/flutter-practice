import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/flutter_bloc/bloc.dart';

class FlutterBlocCounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (blocContext) => FlutterBlocCounterBloc(),
        child: Scaffold(
          appBar: AppBar(title: Text('Flutter Bloc')),
          body: BlocBuilder<FlutterBlocCounterBloc, int>(
            builder: (blocContext, count) {
              return Center(
                  child: Text(
                '$count',
                style: TextStyle(fontSize: 24.0),
              ));
            },
          ),
          floatingActionButton: Builder(
            builder: (blocContext) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: FloatingActionButton(
                    heroTag: 'fab_add',
                    child: Icon(Icons.add),
                    onPressed: () {
                      // ignore: close_sinks
                      final counterBloc =
                          BlocProvider.of<FlutterBlocCounterBloc>(blocContext);
                      counterBloc.add(CounterEvent.increment);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: FloatingActionButton(
                    heroTag: 'fab_remove',
                    child: Icon(Icons.remove),
                    onPressed: () {
                      // ignore: close_sinks
                      final counterBloc =
                          BlocProvider.of<FlutterBlocCounterBloc>(blocContext);
                      counterBloc.add(CounterEvent.decrement);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
