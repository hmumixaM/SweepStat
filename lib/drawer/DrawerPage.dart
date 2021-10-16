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
        ConfigureItem(),
        //ConfigureFileTab(),
        SettingItem(),
      ]),
    );
  }
}