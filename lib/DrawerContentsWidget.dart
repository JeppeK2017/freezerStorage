import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final String title;
  final List<String> items;

  // required list from main page
  DrawerWidget({Key key, @required this.items, @required this.title})
      : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, widget.items)),
              title: Text(widget.title),
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
                onPressed: () => _addItem(),
                child: Icon(Icons.add),
                tooltip: "Add new item",
              );
            })),
        onWillPop: () => _requestPop(context));
  }

  void _addItem() {
    setState(() {
      widget.items.add("yes yes ${_count++}");
    });
  }

  Future<bool> _requestPop(BuildContext context) {
    Navigator.pop(context, widget.items);
    return new Future.value(false);
  }
}
