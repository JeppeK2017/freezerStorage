import 'package:flutter/material.dart';

import 'DrawerWidget.dart';
import 'dart:developer' as developer;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freezer organization',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Freezer index'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final List<String> sampleList = ["abc", "def", "ghi"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            Text("asd"),
            RaisedButton(
              onPressed: () {
                _navigateAndDisplayList(context);
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => DrawerWidget(items: sampleList)),
//                );
              },
              child: const Text("navigate forward"),
            )
          ],
        ));
  }

  void _navigateAndDisplayList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DrawerWidget(items: sampleList)),
    );
    print(result);
  }
}
