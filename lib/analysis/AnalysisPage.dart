import 'package:flutter/material.dart';

import 'GraphChart.dart';
import 'DataProcessing.dart';
import 'sample.dart';

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
                // child: LineChartSample1(),
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
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Stop"))),
                  SizedBox(width: 25),
                  Expanded(
                      child:
                      ElevatedButton(onPressed: () {
                        buildAlertDialog(context).then((fileName) {
                            print(fileName);
                        });
                      }, child: Text("Export"))),
                ],
              ),
            )
          ],
        ));
  }

  Future<String> buildAlertDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Input the file name: "),
              content: TextField(
                controller: controller,
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 0.5,
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  elevation: 0.5,
                  child: Text("Save"),
                  onPressed: () {
                    Navigator.of(context).pop(controller.text.toString());
                  },
                )
              ]);
        });
  }
}
