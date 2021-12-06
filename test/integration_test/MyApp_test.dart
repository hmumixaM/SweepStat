import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sweep_stat_app/screen/MyApp.dart';

void main() {
  testWidgets("app loads without fatal errors", (WidgetTester tester) {
    tester.pumpWidget(MyApp());
  });
}