import 'package:flutter/material.dart';
import 'package:flutter_practice/rxdart/bloc.dart';

class RxDartCounterPage extends StatefulWidget {
  @override
  _RxDartCounterPageState createState() => _RxDartCounterPageState();
}

class _RxDartCounterPageState extends State<RxDartCounterPage> {
  final RxDartCounterBloc rxDartCounterBloc = RxDartCounterBloc(initialCount: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RxDart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed this button many times: ',
            ),
            StreamBuilder(
              stream: rxDartCounterBloc.counterObservable,
              builder: (context, AsyncSnapshot<int> snapshot) {
                return Text('${snapshot.data}', style: Theme.of(context).textTheme.display1);
              },
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: 'fab_add',
              onPressed: () => rxDartCounterBloc.increment(),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: 'fab_remove',
              onPressed: () => rxDartCounterBloc.decrement(),
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    rxDartCounterBloc.dispose();
    super.dispose();
  }
}
