import 'package:flutter/material.dart';
import 'flutter_bloc/page.dart';
import 'rxdart/page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Flutter Bloc Demo';

    return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text(title)),
            body: Builder(
                builder: (context) => Center(
                        child: ListView(
                      children: ListTile.divideTiles(context: context, tiles: [
                        ListTile(
                            title: Text('Flutter bloc library'),
                            trailing: Icon(Icons.arrow_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FlutterBlocCounterPage()),
                              );
                            }),
                        ListTile(
                            title: Text('RxDart library'),
                            trailing: Icon(Icons.arrow_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RxDartCounterPage()),
                              );
                            }),
                      ]).toList(),
                    )))));
  }
}
