import 'package:flutter/material.dart';

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
      title: Text('Experiments'),
      children: [
        ListTile(
          title: Text('Experiment 1'),
          subtitle: Text('Sept. 29th, 15:31'),
          onTap: () => {},
        ),
        ListTile(
          title: Text('Experiment 2'),
          subtitle: Text('Sept. 29th, 15:40'),
          onTap: () => {},
        ),
        ListTile(
          title: Text('Experiment 3'),
          subtitle: Text('Sept. 29th, 18:31'),
          onTap: () => {},
        ),
      ],
    );
  }
}