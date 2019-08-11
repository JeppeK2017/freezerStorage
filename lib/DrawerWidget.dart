import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final List<String> items;

  // required list from main page
  DrawerWidget({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("second screen"),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, int index) {
            return (ListTile(
              title: Text(items[index]),
            ));
          },
        ),
        floatingActionButton: new Builder(builder: (BuildContext context) {
          return new FloatingActionButton(
              onPressed: () {
                final snackBar = SnackBar(
                    content: Text("yes"), duration: Duration(seconds: 4));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: Icon(Icons.add));
        }));
  }
}
