import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweep_stat_app/drawer/DrawerPage.dart';

void main() {
  testWidgets("drawer page successfully created with one child",
      (WidgetTester tester) async {
      var scaffoldKey = GlobalKey<ScaffoldState>();
    await tester.runAsync(() async => tester.pumpWidget(MaterialApp(
          home: Scaffold(
            drawer: DrawerPage(),
            key: scaffoldKey,
          ),
        )));

    scaffoldKey.currentState.openDrawer();
    var drawerChildFinder = find.byType(ListView, skipOffstage: false);
    await tester.pump();
    expect(drawerChildFinder, findsOneWidget);
  });
}
