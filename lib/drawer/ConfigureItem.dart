import 'package:flutter/material.dart';

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
      title: Text('Configurations'),
      children: [
        ListTile(
          title: Text('Configuration 1'),
          subtitle: Text('20 nA/V'),
          onTap: () => {},
        ),
        ListTile(
          title: Text('Configuration 2'),
          subtitle: Text('10 nA/V'),
          onTap: () => {},
        ),
        ListTile(
          title: Text('Configuration 3'),
          subtitle: Text('25 nA/V'),
          onTap: () => {},
        ),
      ],
    );
  }
}