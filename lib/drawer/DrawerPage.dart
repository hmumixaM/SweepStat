import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import 'ConfigureItem.dart';
import 'ExperimentItem.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        Container(
          height: 80.0,
          //width: 100.0,
          child: const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(75, 156, 211, 0.8),
            ),
            child: Text('File Management', style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center,),
          ),
        ),
        ConfigureItem(),
        //ConfigureFileTab(),
        ExperimentItem(),
      ]),
    );
  }

  static Future<List> generateMenuList(EntryType type) async{
    Database db = await DBManager.startDBConnection();
    List query = await DBManager.queryEntireTable(db, type);
    DBManager.closeDBConnection(db);
    return query;
  }
}