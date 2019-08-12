import 'package:flutter/material.dart';

class DrawerFrontWidget extends StatelessWidget {
  final String name;

  DrawerFrontWidget({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.lightBlue.withAlpha(30),
        onTap: () => print("${this.name} card tapped"),
        child: ListTile(
          leading: Icon(Icons.folder),
          title: Text(this.name),
        ),
      ),
    );
  }
}
