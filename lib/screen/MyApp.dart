import 'package:flutter/material.dart';
import 'package:sweep_stat_app/analysis/GraphChart.dart';
import '../bluetooth/BluetoothMenu.dart';
import '../drawer/DrawerPage.dart';
import '../end_drawer/EndDrawerPage.dart';

class MyNewApp extends StatelessWidget {
  const MyNewApp({Key key}) : super(key: key);

  static const appTitle = 'SweepStat';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
      debugShowCheckedModeBanner: false,
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
                onPressed: () => Scaffold.of(context).openDrawer(),
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
      body: GraphChart(),
      drawer: DrawerPage(),
      endDrawer: EndDrawerPage(),
    );
  }
}
