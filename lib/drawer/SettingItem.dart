import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'SettingFileTab.dart';
import 'package:sweep_stat_app/experiment/Experiment.dart';

class ExperimentMetadata {
  String name;
  String type;
  String month;
  String date;
  String time;

  ExperimentMetadata({this.name, this.type, this.month, this.date, this.time});
}

class SettingItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingItem();
  }
}

class _SettingItem extends State<SettingItem> {
  final List<String> nameList = <String>['Experiment 1', 'Experiment 2', 'Experiment 3'];
  final List<String> monthVList = <String>["Sep", "Oct", "Nov"];
  final List<String> dateVList = <String>["29th", "2nd", "13th"];
  final List<String> timeVList = <String>["13:24", "20:15", "8:54"];
  final List<String> typeList = <String>['CV', 'CV', 'CV'];
  List<ExperimentMetadata> ExperimentList = <ExperimentMetadata>[];
  @override
  Widget build(BuildContext context) {
    for (int i=0; i<nameList.length; i++) {
      ExperimentMetadata newExperiment = new ExperimentMetadata(
        name: nameList[i],
        month: monthVList[i],
        date: dateVList[i],
        time: timeVList[i],
        type: typeList[i],
      );
      ExperimentList.add(newExperiment);
    };
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text('Experiments', textScaleFactor: 1.25,),
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: ExperimentList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildExperiment(ExperimentList[index]);
          },
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Show All'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingFileTab(),
              ),
            );
          },
        ),
      ],
    );
  }
  Widget _buildExperiment(ExperimentMetadata metadata,){ //Experiment experiment) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Text(metadata.name),
      ),
      subtitle: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
        child: Text("Date: "+metadata.month+", "+metadata.date+", "+ metadata.time + "\n" + "Experiment Type: " + metadata.type,
            style: TextStyle(height: 1.5)),
      ),
      leading: IconButton(
        icon: Icon(Icons.ios_share_outlined, color: Colors.blue),
        onPressed: () async {
          ExperimentSettings validCVSettings = VoltammetrySettings(
            initialVoltage: .5,
            vertexVoltage: 2.5,
            finalVoltage: .5,
            scanRate: .2,
            sampleInterval: .01,
            sweepSegments: 6,
            gainSetting: GainSettings.uA1,
            electrode: Electrode.silver,
          );

          Experiment validExperiment = Experiment(validCVSettings);
          List<FlSpot> returnable = []; //
          for(int i = 0; i < 200; i++){ //
            returnable.add(FlSpot(i*.01, sin(i*.01))); //
          } //
          validExperiment.dataL = returnable;

          await validExperiment.shareFile(metadata.name);
        },
      ),
    );
  }
}