import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import '../bluetooth/BluetoothMenu.dart';
import 'package:sweep_stat_app/analysis/AnalysisPage.dart';
import '../drawer/DrawerPage.dart';
import '../end_drawer/EndDrawerPage.dart';
import 'IntroScreen.dart';
import 'StateWidget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  static const appTitle = 'SweepStat';

  @override
  Widget build(BuildContext context) {
    return StateWidget(
        child: MaterialApp(
      title: appTitle,
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title, this.intro}) : super(key: key);

  final String title;
  final Intro intro;

  @override
  State<StatefulWidget> createState() {
    return _MyHomePage(title: title, intro: intro);
  }
}

class _MyHomePage extends State<MyHomePage> {
  _MyHomePage({this.title, this.intro});

  final String title;
  final Intro intro;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(
        milliseconds: 500,
      ),
      () {
        intro.start(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
<<<<<<< HEAD
                key: intro.keys[5],
                onPressed: () async {
                  Database db = await DBManager.startDBConnection();
                  List configs =
                      await DBManager.queryEntireTable(db, EntryType.config);
=======
                onPressed: () {
>>>>>>> DB-Work
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu)),
          ),
          actions: <Widget>[
            BluetoothMenu(key: intro.keys[1]),
            Builder(
              builder: (context) => IconButton(
                  key: intro.keys[0],
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(Icons.settings)),
            )
          ]),
      body: AnalysisPage(startKey: intro.keys[2], saveKey: intro.keys[3], shareKey: intro.keys[4],),
      drawer: DrawerPage(),
      endDrawer: EndDrawerPage(),
    );
  }
}
