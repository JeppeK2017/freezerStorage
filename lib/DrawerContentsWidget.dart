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
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteItem(widget.items[index])),
              ));
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "Add new item",
            onPressed: () async {
              String newItemName = await _asyncInputDialog(context);
              if (newItemName != null && newItemName.isNotEmpty) {
                _addItem(newItemName);
              }
            },
          ),
        ),
        onWillPop: () => _requestPop(context));
  }

  void _addItem(String name) {
    setState(() {
      print(widget.items);
      widget.items.add(name);
      print(widget.items);
    });
  }

  void _deleteItem(String name) {
    setState(() {
      print(widget.items);
      widget.items.remove(name);
      print(widget.items);
    });
  }

  Future<bool> _requestPop(BuildContext context) {
    Navigator.pop(context, widget.items);
    return new Future.value(false);
  }
}

Future<String> _asyncInputDialog(BuildContext context) async {
  String input = "";
  return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter new item name"),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: "Item name", hintText: "eg. meat"),
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
