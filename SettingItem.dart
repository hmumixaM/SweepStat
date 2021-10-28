import 'package:flutter/material.dart';
import 'SettingFileTab.dart';

class Experiment {
  String name;
  String type;
  String month;
  String date;
  String time;

  Experiment({this.name, this.type, this.month, this.date, this.time});
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
  List<Experiment> ExperimentList = <Experiment>[];
  @override
  Widget build(BuildContext context) {
    for (int i=0; i<nameList.length; i++) {
      Experiment newExperiment = new Experiment(
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
  Widget _buildExperiment(Experiment items) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Text(items.name),
      ),
      subtitle: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
        child: Text("Date: "+items.month+", "+items.date+", "+ items.time + "\n" + "Experiment Type: " + items.type,
            style: TextStyle(height: 1.5)),
      ),
    );
  }
}