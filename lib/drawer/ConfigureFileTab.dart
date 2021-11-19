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
    var currentConfig = BackEnd.of(context).getSetting();
    ExperimentSettings loadedConfig = ExperimentSettings.fromDBMap(entry);
    if (currentConfig != null &&
        currentConfig.hasSameParameters(loadedConfig)) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text("Action Unavailable"),
              content: const Text(
                  "You are trying to delete the active configuration. Please switch to another configuration before trying again."),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      Database db = await DBManager.startDBConnection();
      DBManager.deleteObject(db, EntryType.config, entry["title"]);
      DBManager.closeDBConnection(db);

      setState(() {
        List<Map<String, dynamic>> modified = List.from(queryList);
        modified.removeAt(index);
        queryList = modified;
      });
    }
  }
}
