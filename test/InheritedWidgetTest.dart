import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweep_stat_app/screen/StateWidget.dart';
import 'package:sweep_stat_app/screen/CoreState.dart';


// TODO: Test based on this sample test: https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/inherited_test.dart
void main() {
  testWidgets('Inherited widget value assignment', (WidgetTester tester) async {
    final List<BackEnd> log = <BackEnd>[];
    final Builder builder = Builder(
      builder: (BuildContext context) {
        log.add(context.dependOnInheritedWidgetOfExactType<BackEnd>());
        return Container();
      },
    );

    final BackEnd first = BackEnd(child: builder);
    await tester.pumpWidget(first);

    expect(log, equals(<BackEnd>[first]));
  });


}