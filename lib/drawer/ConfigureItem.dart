import 'package:flutter/material.dart';
import 'ConfigureFileTab.dart';

class ConfigureItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigureItem();
  }
}

class _ConfigureItem extends State<ConfigureItem> {
  @override
  Widget build(BuildContext context) {

    return ExpansionTile(
      title: Text('Configurations',
        textScaleFactor: 1.25,),
      children: [
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Configuration 1'),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
            child: Text('20 nA/V'),
          ),
          onTap: () => {},
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Configuration 2'),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
            child: Text('10 nA/V'),
          ),
          onTap: () => {},
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Configuration 3'),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
            child: Text('25 nA/V'),
          ),
          onTap: () => {},
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Show All'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfigureFileTab(),
              ),
            );
          },
        ),
      ],
    );
  }
}