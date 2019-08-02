import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final List<String> items;

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
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.add)),
    );
  }
}
