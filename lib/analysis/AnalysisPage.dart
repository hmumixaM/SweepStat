import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/drawer/ExperimentItem.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import '../analysis/LineChartWidget.dart';
import '../experiment/Experiment.dart';
import 'DataProcessing.dart';
import '../screen/StateWidget.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({this.startKey, this.saveKey, this.shareKey});

  final Key startKey, saveKey, shareKey;

  @override
  State<StatefulWidget> createState() {
    return _AnalysisPage(
        startKey: startKey, saveKey: saveKey, shareKey: shareKey);
  }
}

class _AnalysisPage extends State<AnalysisPage> {
  _AnalysisPage({this.startKey, this.saveKey, this.shareKey});

  final Key startKey, saveKey, shareKey;
  List<List<FlSpot>> _curves;

  @override
  void initState() {
    _curves = [
      [FlSpot(0, 0)],
      [FlSpot(0, 0)]
    ];
    //BackEnd.of(context).getProcess().updateGraph(updateGraph);
    super.initState();
  }

  void updateGraph(Experiment experiment) {
    if (mounted) {
      setState(() {
        _curves[0] = experiment.dataL;
        _curves[1] = experiment.dataR;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<List<List>> data = DataProcessing.read();
    return SafeArea(
        child: Column(
          children: [
          Container(
          height: 420,
          width: 420,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 15,
              right: 15,
            ),
            child: LineChartWidget(_curves),
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
            child: ElevatedButton(
            key: startKey,
                onPressed: () {
                  BackEnd.of(context)
                      .getProcess()
                      .startExperiment(context, updateGraph);
                },
                child: Text("Start"))),
        SizedBox(width: 25),
        Expanded(
            child: ElevatedButton(
                key: saveKey, onPressed: () {buildAlertDialog(context);}, child: Text("Save"))),
        SizedBox(width: 25),

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
                  onPressed: () async {
                    Database db = await DBManager.startDBConnection();
                    var metadata = ExperimentMetadata(name: controller.text, timestamp: DateTime.now());
                    var e = SavedExperiment(
                      experiment:BackEnd.of(context).getExp(),
                      metadata: metadata,
                      settings: BackEnd.of(context).getSetting());
                    await DBManager.addObject(db, EntryType.experiment, e.toDBMap());
                    await DBManager.closeDBConnection(db);

                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }
}
