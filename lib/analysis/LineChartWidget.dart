import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  final List<List<FlSpot>> curves;

  LineChartWidget(this.curves);

  @override
  State<StatefulWidget> createState() {
    return _LineChartWidget();
  }
}

class _LineChartWidget extends State<LineChartWidget> {

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

  FlSpot point = FlSpot(0, 0);

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        lineTouchData: LineTouchData(
          touchCallback: (FlTouchEvent e, LineTouchResponse lineTouch) {
            if (lineTouch != null && lineTouch.lineBarSpots != null) {
              setState(() {
                // print(lineTouch.original);
                point = FlSpot(lineTouch.lineBarSpots[2].x, lineTouch.lineBarSpots[2].y);
              });
            }
          },
          handleBuiltInTouches: false,
        ),
        lineBarsData: widget.curves
                .map((e) => LineChartBarData(
                        spots: e,
                        isCurved: true,
                        dotData: FlDotData(show: false),
                        colors: [
                          availableColors[
                              Random().nextInt(availableColors.length)]
                        ]))
                .toList() +
            [
              LineChartBarData(
                spots: [point],
                isCurved: true,
                dotData: FlDotData(show: true),
              )
            ],
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
        )));
  }
}
