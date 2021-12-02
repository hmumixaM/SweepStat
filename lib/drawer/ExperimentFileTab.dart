import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/experiment/Experiment.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import 'package:sweep_stat_app/screen/StateWidget.dart';

import 'ExperimentItem.dart';

class ExperimentFileTab extends StatefulWidget {
  final List<Map> queryList;
  ExperimentFileTab(List<Map> queryList) : this.queryList = queryList;

  @override
  State<StatefulWidget> createState() {
    return _ExperimentFileTab(queryList);
  }
}

class _ExperimentFileTab extends State<ExperimentFileTab> {
  List<Map<String, dynamic>> queryList;
  _ExperimentFileTab(List<Map> queryList) : this.queryList = queryList;

  @override
  Widget build(BuildContext context) {
    //final List<String> entries = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    //final List<int> colorCodes = <int>[600, 500, 100];
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(75, 156, 211, 0.8),
          title: const Text('Configuration List'),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: queryList.length,
          itemBuilder: (BuildContext context, int index) =>
              ExperimentItem.widgetizeExperiment(
                  SavedExperiment.fromDBMap(queryList[index]), () {
            deleteElement(queryList[index], index);
          }, context),
        ));
  }

  void deleteElement(Map<String, dynamic> entry, int index) async {
    Database db = await DBManager.startDBConnection();
    print(entry['title']);
    await DBManager.deleteObject(db, EntryType.experiment, entry["title"]);
    print(await DBManager.queryEntireTable(db, EntryType.experiment));
    await DBManager.closeDBConnection(db);

    setState(() {
      List<Map<String, dynamic>> modified = List.from(queryList);
      modified.removeAt(index);
      queryList = modified;
    });
  }
}
