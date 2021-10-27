import 'package:flutter_test/flutter_test.dart';
import 'package:sweep_stat_app/analysis/DataProcessing.dart';

import 'package:sweep_stat_app/main.dart';

void main() {
  test('Float numbers should be rounded', () {
    expect(DataProcessing.roundTo(1.7232, 2), 172.32);
    expect(DataProcessing.roundTo(0, 2), 0);
    expect(DataProcessing.roundTo(100, 1), 10000);
    expect(DataProcessing.roundTo(0.001223, 3), 0.122);
  });
}