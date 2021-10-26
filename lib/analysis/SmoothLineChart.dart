import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 数据
class SmoothData {
  // 月份 - 数字
  int month;
  // 数据
  double data;

  SmoothData({this.month, this.data});
}

class SmoothLineChart extends StatelessWidget {
  final List<SmoothData> datas;
  final void Function(int index) onSelect;
  final int selectIndex;
  SmoothLineChart({
    Key key,
    this.datas,
    this.onSelect,
    this.selectIndex = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 0, right: 5),
        child: LineChart(
          mainData(),
          swapAnimationDuration: Duration(milliseconds: 500),
        ),
      ),
    );
  }

  /// 获取X轴显示的日期
  String getxTitles(double value) {
    SmoothData data = datas[value.toInt()];
    int month = data.month;
    Map<String, String> months = {
      "1": '1月',
      "2": '2月',
      "3": '3月',
      "4": '4月',
      "5": '5月',
      "6": '6月',
      "7": '7月',
      "8": '8月',
      "9": '9月',
      "10": '10月',
      "11": '11月',
      "12": '12月'
    };
    String monthStr = months[month.toString()];
    return monthStr ?? "";
  }

  /// 获取显示的数据
  List<FlSpot> get spots {
    return datas.asMap().entries.map((e) {
      int index = e.key;
      SmoothData data = e.value;
      return FlSpot(index.toDouble(), data.data);
    }).toList();
  }

  /// 获取Y轴最大值
  ///
  double get maxY {
    double _maxY = datas.map((e) => e.data).toList().reduce(max);
    if (_maxY == 0) {
      return 20;
    } else {
      int space = ((_maxY / 3).ceil());
      return space * 3.0;
    }
  }

  /// 获取Y轴显示的值
  String getyTitles(double value) {
    int space = maxY ~/ 3;
    if (value % space == 0) {
      return value.toString();
    }
    return "";
  }

  /// 获取虚线
  FlLine getDrawingHorizontalLine(double value) {
    int space = maxY ~/ 3;
    if (value % space == 0) {
      return FlLine(
        color: Color(0x20999999),
        strokeWidth: 2,
        dashArray: [5, 10],
      );
    } else {
      return FlLine(
        color: Color(0x20999999),
        strokeWidth: 0,
        dashArray: [5, 10],
      );
    }
  }

  /// 绘制折线图
  LineChartData mainData() {
    return LineChartData(
      lineTouchData: touchData(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: getDrawingHorizontalLine,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 16,
          getTextStyles: (context, value) {
            return TextStyle(
              color: value.toInt() == selectIndex ? Colors.black : Colors.black26,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            );
          },
          getTitles: getxTitles,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.w400,
            fontSize: 10,
          ),
          getTitles: getyTitles,
          reservedSize: 16,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Color(0x20999999),
            width: 1,
          ),
        ),
      ),
      minX: 0,
      maxX: 5,
      minY: 0,
      maxY: maxY,
      lineBarsData: lineBarsData,
      showingTooltipIndicators: [selectIndex].map((index) {
        final tooltipsOnBar = lineBarsData[0];
        return ShowingTooltipIndicators([
          LineBarSpot(
              tooltipsOnBar, lineBarsData.indexOf(tooltipsOnBar), tooltipsOnBar.spots[index]),
        ]);
      }).toList(),
    );
  }

  final Color lineColor = Color(0xFF1554FF);
  final List<Color> colors = [
    Color(0xFF0044FF).withOpacity(0.3),
    Color(0x00B1D0FF),
  ];

  List<int> get showIndexes {
    return List.generate(datas.length, (index) => index);
  }

  List<LineChartBarData> get lineBarsData => [
    LineChartBarData(
      spots: spots,
      showingIndicators: showIndexes,
      isCurved: true,
      colors: [lineColor],
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: colors,
        gradientColorStops: [0.0, 1.0],
        gradientFrom: const Offset(0, 0),
        gradientTo: const Offset(0, 1),
      ),
    ),
  ];

  // 点击折线图
  LineTouchData touchData() {
    return LineTouchData(
        enabled: false,
        touchSpotThreshold: 30,
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(color: Colors.transparent, strokeWidth: 0),
              FlDotData(
                show: selectIndex == spotIndex ? true : false,
                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 2,
                  color: Colors.white,
                  strokeWidth: 3,
                  strokeColor: Colors.blue,
                ),
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
            tooltipMargin: 2,
            tooltipBgColor: Colors.transparent,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  flSpot.y.toString(),
                  TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                  children: [
                    TextSpan(
                      text: ' k ',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }).toList();
            }),
        touchCallback: (FlTouchEvent e, LineTouchResponse lineTouch) {
          final desiredTouch = e.isInterestedForInteractions;
          if (desiredTouch && lineTouch.lineBarSpots != null) {
            final value = lineTouch.lineBarSpots[0].x;
            onSelect.call(value.toInt());
          } else {}
        });
  }
}
