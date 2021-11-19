import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import 'package:sweep_stat_app/screen/StateWidget.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'ConfigureFileTab.dart';
import 'DrawerPage.dart';

class Config {
  String name;
  double initialV;
  double vertexV;
  double finalV;

  Config({this.name, this.initialV, this.finalV, this.vertexV});
}

class ConfigureItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigureItem();
  }

  static widgetizeConfig(Map<String, dynamic> entry, BuildContext context, void Function() onDelete){
    ExperimentSettings currentConfig = BackEnd.of(context).getSetting();
    var loadedConfig = ExperimentSettings.fromDBMap(entry);

    return Container(
        color: currentConfig != null &&
            currentConfig.hasSameParameters(loadedConfig)
            ? Color.fromRGBO(75, 156, 211, 0.8).withOpacity(0.5)
            : Colors.transparent,
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text(entry["title"]),
          ),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
            child: Text(
                entry["type"] == "Voltammetry"
                    ? "Initial Voltage: " +
                    entry["initialVoltage"].toString() +
                    ", " +
                    "Vertex Voltage: " +
                    entry["vertexVoltage"].toString() +
                    ", " +
                    "Final Voltage: " +
                    entry["finalVoltage"].toString()
                    : //split here
                "Initial Voltage: " +
                    entry["initialVoltage"].toString() +
                    ", " +
                    "Sample Interval: " +
                    entry["sampleInterval"].toString() +
                    ", " +
                    "Run Time: " +
                    entry["runtime"].toString(),
                style: TextStyle(height: 1.5)),
          ),
          onTap: () {
            BackEnd.of(context).newSettings(ExperimentSettings.fromDBMap(entry));
            Navigator.pop(context);
          },
          trailing: IconButton(
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.red,
            ),
            onPressed: onDelete,
          ),
        ));
  }

  static List<Widget> dbQueryToWidgets(List<Map> query, bool limit, BuildContext context, void Function() onDelete) {
    List<Widget> output = [];

    if (query.length > 3 && limit) {
      output.add(widgetizeConfig(query[0], context, onDelete));
      output.add(widgetizeConfig(query[1], context, onDelete));
      output.add(widgetizeConfig(query[2], context, onDelete));
    } else {
      for (Map entry in query) {
        output.add(widgetizeConfig(entry, context, onDelete));
      }
    }

    return output;
  }

  static List<Widget> buildConfigDrawerMenu(List<Map> query, BuildContext context, void Function() onDelete) {
    var output = dbQueryToWidgets(query, true, context, onDelete);
    output.add(
      ListTile(
        title: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          child: Text('Show All'),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ConfigureFileTab(query),
            ),
          );
        },
      ),
    );
    return output;
  }
}

class _ConfigureItem extends State<ConfigureItem> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              'Configurations',
              textScaleFactor: 1.25,
            ),
            children: ConfigureItem.buildConfigDrawerMenu(snapshot.data, context, () {}),
          );
        }
      },
      future: DrawerPage.generateMenuList(EntryType.config),
    );
  }
}
