import 'package:flutter/material.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import 'package:sweep_stat_app/screen/StateWidget.dart';
import 'DrawerPage.dart';
import 'package:sweep_stat_app/experiment/Experiment.dart';

import 'ExperimentFileTab.dart';

class ExperimentMetadata {
  String name;
  DateTime timestamp;

  ExperimentMetadata({this.name, this.timestamp});
}

class ExperimentItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExperimentItem();
  }

  static List<Widget> dbQueryToWidgets(List<Map> query, bool limit, BuildContext context, void Function() onDelete) {
    List<Widget> output = [];
    List<SavedExperiment> convertedResults = query.map((e) => SavedExperiment.fromDBMap(e)).toList();

    if (query.length > 3 && limit) {
      output.add(widgetizeExperiment(convertedResults[0], onDelete, context));
      output.add(widgetizeExperiment(convertedResults[1], onDelete, context));
      output.add(widgetizeExperiment(convertedResults[2], onDelete, context));
    } else {
      for (SavedExperiment entry in convertedResults) {
        output.add(widgetizeExperiment(entry, onDelete, context));
      }
    }

    return output;
  }

  static Widget widgetizeExperiment(SavedExperiment e, void Function() onDelete, BuildContext context) {
    Experiment experiment = e.experiment;
    ExperimentMetadata metadata = e.metadata;
    ExperimentSettings settings = e.settings;
    String experimentType = (settings is VoltammetrySettings) ? "Voltammetry" : "Amperometry";

    return ListTile(
      title: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Text(metadata.name),
      ),
      subtitle: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
        child: Text("Date: "+metadata.timestamp.toString()+"\n" + "Experiment Type: " + experimentType,
            style: TextStyle(height: 1.5)),
      ),
      leading: IconButton(
        icon: Icon(Icons.ios_share_outlined, color: Colors.blue),
        onPressed: () async {
          await e.shareFile();
        },
      ),
      trailing: onDelete == null ? null : IconButton(
        icon: Icon(
          Icons.delete_forever_outlined,
          color: Colors.red,
        ),
        onPressed: onDelete,
      ),
      onTap: () {
        BackEnd.of(context).newExperiment(experiment);
        BackEnd.of(context).newSettings(settings);
        Navigator.pop(context);
      },
    );
  }
}

class _ExperimentItem extends State<ExperimentItem> {

  List<Widget> buildExperimentDrawerMenu(List<Map> query, BuildContext context, void Function() onDelete) {
    var output = ExperimentItem.dbQueryToWidgets(query, true, context, onDelete);
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
                  ExperimentFileTab(query),
            ),
          );
          setState(() {});
        },
      ),
    );
    return output;
  }

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
              'Experiments',
              textScaleFactor: 1.25,
            ),
            children: buildExperimentDrawerMenu(snapshot.data, context, null),
          );
        }
      },
      future: DrawerPage.generateMenuList(EntryType.experiment),
    );
  }
}