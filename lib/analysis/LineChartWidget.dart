import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<List<FlSpot>> curves;
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.deepOrange,
    Colors.lime,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
    Colors.redAccent,
  ];

  LineChartWidget(this.curves);

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        clipData: FlClipData.all(),
        lineBarsData: curves
            .map((e) => LineChartBarData(
                    spots: e,
                    isCurved: true,
                    dotData: FlDotData(show: false),
                    colors: [
                      availableColors[Random().nextInt(availableColors.length)]
                    ]))
            .toList(),
        axisTitleData: FlAxisTitleData(
          show: true,
          leftTitle: AxisTitle(
              showTitle: true,
              titleText: "Current/nA",
              textStyle:
              TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
          bottomTitle: AxisTitle(
              showTitle: true,
              titleText: "Potential/V",
              textStyle:
              TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
          topTitle: AxisTitle(
              showTitle: true,
              titleText: "Current Vs Potential",
              textStyle:
              TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        )
    ));
  }
}
