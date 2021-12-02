import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import '../bluetooth/BluetoothMenu.dart';
import 'package:sweep_stat_app/analysis/AnalysisPage.dart';
import '../drawer/DrawerPage.dart';
import '../end_drawer/EndDrawerPage.dart';
import 'IntroScreen.dart';
import 'StateWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  static const appTitle = 'SweepStat';

  Future checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('first') == null) {
      print('first time');
      await prefs.setInt('first', 1);
      return IntroScreen.id;
    } else {
      print('other');
      return HomeScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkFirstTime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return StateWidget(
                child: MaterialApp(
              title: appTitle,
              debugShowCheckedModeBanner: false,
              initialRoute: snapshot.data,
              routes: {
                IntroScreen.id: (context) => IntroScreen(),
                HomeScreen.id: (context) => HomeScreen(),
              },
            ));
          }
        });
  }
}

class HomeScreen extends StatelessWidget {
  static String id = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    var keys = [
      UniqueKey(),
      UniqueKey(),
      UniqueKey(),
      UniqueKey(),
      UniqueKey(),
      UniqueKey()
    ];
    return Scaffold(
      appBar: AppBar(
          title: Text('SweepStat'),
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
                key: keys[5],
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu)),
          ),
          actions: <Widget>[
            BluetoothMenu(key: keys[1]),
            Builder(
              builder: (context) => IconButton(
                  key: keys[0],
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(Icons.settings)),
            )
          ]),
      body: AnalysisPage(
        startKey: keys[2],
        saveKey: keys[3],
        shareKey: keys[4],
      ),
      drawer: DrawerPage(),
      endDrawer: EndDrawerPage(),
    );
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
                key: intro.keys[5],
                onPressed: () {
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
      body: AnalysisPage(
        startKey: intro.keys[2],
        saveKey: intro.keys[3],
        shareKey: intro.keys[4],
      ),
      drawer: DrawerPage(),
      endDrawer: EndDrawerPage(),
    );
  }
}
