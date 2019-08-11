import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final List<String> items;

  // required list from main page
  DrawerWidget({Key key, @required this.items}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, widget.items)),
          title: Text("second screen"),
        ),
        body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, int index) {
            return (ListTile(
              title: Text(widget.items[index]),
            ));
          },
        ),
        floatingActionButton: new Builder(builder: (BuildContext context) {
          return new FloatingActionButton(
              onPressed: () => _addItems(), child: Icon(Icons.add));
        }));
  }

  void _addItems() {
    setState(() {
      widget.items.add("yes yes ${_count++}");
    });
  }
}
