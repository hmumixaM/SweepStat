import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import 'package:sweep_stat_app/screen/StateWidget.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'ConfigureItem.dart';

class ConfigureFileTab extends StatefulWidget {
  final List<Map> queryList;
  ConfigureFileTab(List<Map> queryList) : this.queryList = queryList;

  @override
  State<StatefulWidget> createState() {
    return _ConfigureFileTab(queryList);
  }
}

class _ConfigureFileTab extends State<ConfigureFileTab> {
  List<Map<String, dynamic>> queryList;
  _ConfigureFileTab(List<Map> queryList) : this.queryList = queryList;

  @override
  Widget build(BuildContext context) {
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
        itemCount: queryList.length,
        itemBuilder: (BuildContext context, int index) =>
            ConfigureItem.widgetizeConfig(queryList[index], context, () {
          deleteElement(queryList[index], index);
        }),
        padding: const EdgeInsets.all(8),
      ),
    );
  }

  void deleteElement(Map<String, dynamic> entry, int index) async {
    ExperimentSettings loadedConfig = ExperimentSettings.fromDBMap(entry);

    Database db = await DBManager.startDBConnection();
    await DBManager.deleteObject(db, EntryType.config, entry["title"]);
    await DBManager.closeDBConnection(db);

    setState(() {
      List<Map<String, dynamic>> modified = List.from(queryList);
      modified.removeAt(index);
      queryList = modified;
    });
  }
}
