import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import 'ConfigureItem.dart';
import 'ExperimentItem.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        ConfigureItem(),
        //ConfigureFileTab(),
        ExperimentItem(),
      ]),
    );
  }

  static Future<List> generateMenuList(EntryType type) async {
    Database db = await DBManager.startDBConnection();
    List query = await DBManager.queryEntireTable(db, type);
    DBManager.closeDBConnection(db);
    return query;
  }
}
