import 'package:flutter/material.dart';

import 'GraphChart.dart';
import 'DataProcessing.dart';

class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<List>> data = DataProcessing.read();
    return SafeArea(
        child: Column(
      children: [
        Container(
          height: 630,
          width: 420,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 15,
              right: 15,
            ),
            child: GraphChart(data),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 35,
            bottom: 35,
            left: 35,
            right: 35,
          ),
          child: Row(
            children: [
              Expanded(
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Start"))),
              SizedBox(width: 25),
              Expanded(
                  child: ElevatedButton(onPressed: () {}, child: Text("Stop"))),
              SizedBox(width: 25),
              Expanded(
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Export"))),
            ],
          ),
        )
      ],
    ));
  }
}
