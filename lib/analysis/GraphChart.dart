import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GraphChart();
  }

}

class _GraphChart extends State<GraphChart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        maxX: 8,
        minX: 0,
        clipData: FlClipData.all(),
        lineBarsData: [
          LineChartBarData(spots: [
            FlSpot(0, 1),
            FlSpot(1, 3),
            FlSpot(2, 10),
            FlSpot(3, 7),
            FlSpot(4, 12),
            FlSpot(5, 13),
            FlSpot(6, 17),
            FlSpot(7, 15),
            FlSpot(8, 20)
          ], isCurved: true, dotData: FlDotData(show: false)),
          LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 3),
                FlSpot(2, 10),
                FlSpot(3, 7),
                FlSpot(4, 12),
                FlSpot(5, 13),
                FlSpot(6, 17),
                FlSpot(7, 15),
                FlSpot(8, 20)
              ],
              isCurved: true,
              curveSmoothness: .1,
              colors: [Colors.blueAccent],
              dotData: FlDotData(show: false))
        ],
        axisTitleData: FlAxisTitleData(
          show: true,
          leftTitle: AxisTitle(
              showTitle: true,
              titleText: "Current/nA",
              textStyle: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.black)),
          bottomTitle: AxisTitle(
              showTitle: true,
              titleText: "Potential/V",
              textStyle: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.black)),
          topTitle: AxisTitle(
              showTitle: true,
              titleText: "Current Vs Potential",
              textStyle: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.black)),
        )));
  }

}