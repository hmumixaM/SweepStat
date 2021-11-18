import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:introduction_screen/introduction_screen.dart';
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
      home: Builder(
        builder: (context) => introPage(context)),
      debugShowCheckedModeBanner: false,
    ));
  }

  Widget introPage(BuildContext context) {
    List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        title: "Title of first page",
        body:
            "Here you can write the description of the page, to explain someting...",
        image:
            Center(child: Image.asset("images/sweephelper.png", height: 175.0)),
        decoration: const PageDecoration(
          pageColor: Colors.blue,
        ),
      ),
      PageViewModel(
        title: "Title of second page",
        body:
            "Here you can write the description of the page, to explain someting...",
        image:
            Center(child: Image.asset("images/sweepstat.png", height: 175.0)),
        decoration: const PageDecoration(
          pageColor: Colors.blue,
        ),
      )
    ];

    return IntroductionScreen(
      pages: listPagesViewModel,
      onDone: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "SweepStat")));
      },
      onSkip: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "SweepStat")));
      },
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.navigate_next),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    Intro intro = Intro(
      noAnimation: false,
      stepCount: 4,
      maskClosable: true,
      onHighlightWidgetTap: (introStatus) {
        print(introStatus);
      },
      padding: EdgeInsets.all(8),
      borderRadius: BorderRadius.all(Radius.circular(4)),
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        texts: [
          'Use this setting to configure your experiments.',
          'Click here to connect SweepStat Bluetooth.',
          'Start your experiment after configure the settings and connect to the bluetooth.',
          'Click here to see your saved configurations and experiments.',
        ],
        buttonTextBuilder: (curr, total) {
          return curr < total - 1 ? 'Next' : 'Finish';
        },
      ),
    );
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
        /// start the intro
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
                key: intro.keys[3],
                onPressed: () async {
                  Database db = await DBManager.startDBConnection();
                  List configs =
                      await DBManager.queryEntireTable(db, EntryType.config);
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
      body: AnalysisPage(buttonKey: intro.keys[2]),
      drawer: DrawerPage(),
      endDrawer: EndDrawerPage(),
    );
  }
}
