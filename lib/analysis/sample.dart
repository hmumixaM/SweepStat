import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sweep_stat_app/analysis/SmoothLineChart.dart';
import 'SmoothLineChart.dart';

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  int selectIndex = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmoothLineChart(
          datas: [
            SmoothData(month: 1, data: 1),
            SmoothData(month: 2, data: 2),
            SmoothData(month: 3, data: 0),
            SmoothData(month: 4, data: 4),
            SmoothData(month: 5, data: 1),
            SmoothData(month: 6, data: 5),
          ],
          selectIndex: selectIndex,
          onSelect: (int index) {
            setState(() {
              if (index != null && selectIndex != index) {
                selectIndex = index;
              }
            });
          },
        )
      ],
    );
  }
}
