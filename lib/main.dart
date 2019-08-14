import 'package:flutter/material.dart';
import 'package:freezer_storage/DatabaseHelper.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // database instance
  final dbHelper = DatabaseHelper.instance;

  final String title;
  final List<String> sampleList = ["abc", "def", "ghi"];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _drawers = new List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _drawers.length,
                  itemBuilder: (context, int index) {
                    final String drawerName = _drawers[index];

                    return Card(
                      child: InkWell(
                        splashColor: Colors.lightBlue.withAlpha(30),
                        onTap: () =>
                            _navigateAndDisplayList(context, drawerName),
                        child: ListTile(
                            leading: SizedBox(
                              width: 40,
                              child: Icon(Icons.folder),
                            ),
                            title: Text(drawerName)),
                      ),
                    );
                  })),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("insert"),
                onPressed: () => _insert("a"),
              ),
              RaisedButton(
                child: Text("query"),
                onPressed: () => _queryAll("a"),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add new drawer",
        onPressed: () async {
          final String newDrawerName = await _asyncInputDialog(context);
          if (newDrawerName != null && newDrawerName.isNotEmpty) {
            _addDrawer(newDrawerName);
          }
        },
      ),
    );
  }

  // insert into a table in database
  void _insert(String tableName) async {
    Map<String, dynamic> row = {"name": 'Bob'};
    final id = await widget.dbHelper.insert(row, tableName);
    print("inserted row id: $id into table $tableName");
  }

  // query all rows of table in database
  Future<List<Map<String, dynamic>>> _queryAll(String tableName) async {
    final allRows = await widget.dbHelper.queryAllRows(tableName);
    print("QuerryAllRows -----------------------------------------");
    allRows.forEach((row) => print(row));
    return allRows;
  }

  void _newTable(String tableName) async {
    await widget.dbHelper.newTable(tableName);
    print("added table named $tableName");
  }

  // title is the name of the drawer and reflects tableName in db
  void _navigateAndDisplayList(BuildContext context, String title) async {
    final currentList = _queryAll(title);
    print(currentList);

    final modifiedList = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DrawerWidget(items: widget.sampleList, title: title)),
    );

    print(modifiedList);
  }

  void _storeModifiedList(String drawerName) {}

  void _addDrawer(String newName) {
    if (!_drawers.contains(newName)) {
      _newTable(newName);
      setState(() {
        _drawers.add(newName);
      });
    } else {
      print("name already exists");
    }
  }
}

// input dialog for new drawer name
Future<String> _asyncInputDialog(BuildContext context) async {
  String input = "";
  return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter new drawer name"),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: "Drawer name", hintText: "eg. Drawer 1"),
                  onChanged: (val) => input = val,
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(input),
            )
          ],
        );
      });
}
