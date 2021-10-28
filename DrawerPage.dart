import 'package:flutter/material.dart';
import 'ConfigureItem.dart';
import 'SettingItem.dart';
import 'ConfigureFileTab.dart';
import 'SettingItem.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        Container(
          height: 65.0,
          //width: 100.0,
          child: const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(75, 156, 211, 0.8),
            ),
            child: Text('File Management', style: TextStyle(fontSize: 20),),
          ),
        ),
        ConfigureItem(),
        //ConfigureFileTab(),
        SettingItem(),
      ]),
    );
  }
}