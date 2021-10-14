import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';


/* This is a class of helper function.
 * read(): read a file for experiment data;
 * splitData(): split a list of numbers into different curves;
 * roundTo(): round the numbers.
 */

class DataProcessing {
  static Future<List<List>> read() async {
    List<List<dynamic>> experimentData = null;
    try {
      var s =  await rootBundle.loadString('assets/example_data.csv');
      experimentData = const CsvToListConverter().convert(s);
      return experimentData;
    } catch (e) {
      print(e);
      print("Couldn't read file");
    }
    return experimentData;
  }

  static List<List<FlSpot>> splitData(List<List> line) {
    List<List<FlSpot>> _curves = [];
    List<FlSpot> current = <FlSpot>[];
    double gap = roundTo(line[1][0], 3) - roundTo(line[0][0], 3);

    for (int i = 0; i < line.length - 1; i++) {
      // print(_roundTo(line[i][0], 3));
      // print(_roundTo(line[i+1][0], 3) - _roundTo(line[i][0], 3));
      if (gap != roundTo(line[i+1][0], 3) - roundTo(line[i][0], 3)) {
        current.add(FlSpot(roundTo(line[line.length-1][0], 3), roundTo(line[line.length-1][1], 6)));
        _curves.add(current);
        current = <FlSpot>[];
        gap = roundTo(line[i+1][0], 3) - roundTo(line[i][0], 3);
      } else {
        current.add(FlSpot(roundTo(line[i][0], 3), roundTo(line[i][1], 6)));
      }
    }
    current.add(FlSpot(roundTo(line[line.length-1][0], 3), roundTo(line[line.length-1][1], 6)));
    _curves.add(current);

    return _curves;
  }

  static double roundTo(double num, int amount) {
    return (num * pow(10, amount) * 100.0).roundToDouble() / 100.0;
  }
}