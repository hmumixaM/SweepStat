import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/file_management/file_manager.dart';
import '../bluetooth/BluetoothMenu.dart';
import 'package:sweep_stat_app/analysis/AnalysisPage.dart';
import '../drawer/DrawerPage.dart';
import '../end_drawer/EndDrawerPage.dart';
import 'StateWidget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  static const appTitle = 'SweepStat';

  @override
  Widget build(BuildContext context) {
    return StateWidget(
      child: MaterialApp(
        title: appTitle,
        home: MyHomePage(title: appTitle),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () async{
                  Database db = await DBManager.startDBConnection();
                  List configs = await DBManager.queryEntireTable(db, EntryType.config);
                  Scaffold.of(context).openDrawer();
                  },
                icon: Icon(Icons.menu)),
          ),
          actions: <Widget>[
            BluetoothMenu(),
            Builder(
              builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(Icons.settings)),
            )
          ]),
      body: AnalysisPage(),
      drawer: DrawerPage(),
      endDrawer: EndDrawerPage(),
    );
  }
}
