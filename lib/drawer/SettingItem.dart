import 'package:flutter/material.dart';
import 'SettingFileTab.dart';

class SettingItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingItem();
  }
}

class _SettingItem extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Experiments', textScaleFactor: 1.25,),
      children: [
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Experiment 1'),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
            child: Text('Sept. 29th, 15:23'),
          ),
          onTap: () => {},
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Experiment 2'),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
            child: Text('Sept. 29th, 15:50'),
          ),
          onTap: () => {},
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Experiment 3'),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
            child: Text('Sept. 29th, 17:23'),
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
                builder: (context) => SettingFileTab(),
              ),
            );
          },
        ),
      ],
    );
  }
}