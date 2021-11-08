import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'DataProcessing.dart';
import 'LineChartWidget.dart';

class GraphChart extends StatefulWidget {
  final Future<List<List>> data;

  GraphChart(this.data);

  @override
  State<StatefulWidget> createState() {
    return _GraphChart();
  }
}

class _GraphChart extends State<GraphChart> {
  List<List<FlSpot>> _curves = [];

  @override
  void initState() {
    widget.data.then((line) =>
        setState(() {
          _curves = DataProcessing.splitData(line);
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LineChartWidget(_curves);
  }
}
