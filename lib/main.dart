import 'package:flutter/material.dart';

import 'DrawerContentsWidget.dart';

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
  final List<int> drawers = [0, 1, 2, 3, 4, 5, 6];

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
                _navigateAndDisplayList(context, "asd");
              },
              child: const Text("navigate forward"),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: drawers.length,
                    itemBuilder: (context, int index) {
                      final String drawerName =
                          drawers[index].toString() + " abcdefg";

                      return Card(
                        child: InkWell(
                          splashColor: Colors.lightBlue.withAlpha(30),
                          onTap: () =>
                              _navigateAndDisplayList(context, drawerName),
                          child: ListTile(
                              leading: Icon(Icons.folder),
                              title: Text(drawerName)),
                        ),
                      );
                    }))
          ],
        ));
  }

  void _navigateAndDisplayList(BuildContext context, String title) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DrawerWidget(items: sampleList, title: title)),
    );
    print(result);
  }
}
