import 'package:flutter/material.dart';
import 'package:sweep_stat_app/file_management/file_manager.dart';
import 'package:sweep_stat_app/screen/StateWidget.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
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
}

class _ConfigureItem extends State<ConfigureItem> {
  /*final List<String> nameList = <String>[
    'Configuration 1',
    'Configuration 2',
    'Configuration 3'
  ];
  final List<double> initialVList = <double>[1, 2, 3];
  final List<double> vertexVList = <double>[4, 5, 6];
  final List<double> finalVList = <double>[7, 8, 9];
  List ConfigList;*/
  List<Map> dbFormattedConfigList;

  _onSelected(ExperimentSettings settings) {
    BackEnd.of(context).newSettings(settings);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        } else {
          return ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              'Configurations',
              textScaleFactor: 1.25,
            ),
            children: dbQueryToWidgets(snapshot.data, true),
          );
        }
      },
      future: DrawerPage.generateMenuList(EntryType.config),
    );

    /*for (int i = 0; i < nameList.length; i++) {
      Config newConfig = new Config(
        name: nameList[i],
        initialV: initialVList[i],
        vertexV: vertexVList[i],
        finalV: finalVList[i],
      );
      ConfigList.add(newConfig);
    }*/

    /*return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        'Configurations',
        textScaleFactor: 1.25,
      ),
      children: [
        Container(
            color: _selectedIndex != null && _selectedIndex == 1
                ? Color.fromRGBO(75, 156, 211, 0.8).withOpacity(0.5)
                : Colors.transparent,
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Text('Configuration 1'),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                child: Text(
                    "Initial Voltage: " +
                        ConfigList[0].initialV.toString() +
                        ", " +
                        "Vertex Voltage: " +
                        ConfigList[0].vertexV.toString() +
                        ", " +
                        "Final Voltage: " +
                        ConfigList[0].finalV.toString(),
                    style: TextStyle(height: 1.5)),
              ),
              onTap: () => {
                // _onSelected(1),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => EndDrawerPage(
                //       initialV: ConfigList[0].initialV,
                //       vertexV: ConfigList[0].vertexV,
                //       finalV: ConfigList[0].finalV,
                //     ),
                //   ),
                // )
              },
            )),
        Container(
            color: _selectedIndex != null && _selectedIndex == 2
                ? Color.fromRGBO(75, 156, 211, 0.8).withOpacity(0.5)
                : Colors.transparent,
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Text('Configuration 2'),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                child: Text(
                    "Initial Voltage: " +
                        ConfigList[1].initialV.toString() +
                        ", " +
                        "Vertex Voltage: " +
                        ConfigList[1].vertexV.toString() +
                        ", " +
                        "Final Voltage: " +
                        ConfigList[1].finalV.toString(),
                    style: TextStyle(height: 1.5)),
              ),
              onTap: () => {_onSelected(2)},
            )),
        Container(
            color: _selectedIndex != null && _selectedIndex == 3
                ? Color.fromRGBO(75, 156, 211, 0.8).withOpacity(0.5)
                : Colors.transparent,
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Text('Configuration 3'),
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                child: Text(
                    "Initial Voltage: " +
                        ConfigList[2].initialV.toString() +
                        ", " +
                        "Vertex Voltage: " +
                        ConfigList[2].vertexV.toString() +
                        ", " +
                        "Final Voltage: " +
                        ConfigList[2].finalV.toString(),
                    style: TextStyle(height: 1.5)),
              ),
              onTap: () => {_onSelected(3)},
            )),
        ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Text('Show All'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfigureFileTab(
                  initialV: null,
                  vertexV: null,
                  finalV: null,
                ),
              ),
            );
          },
        ),
      ],
    );*/
  }

  List<Widget> dbQueryToWidgets(List<Map> query, bool limit){
    List<Widget> output = [];

    if(query.length > 3 && limit){
      output.add(ConfigListItem(query[0]));
      output.add(ConfigListItem(query[1]));
      output.add(ConfigListItem(query[2]));
    } else {
      for(Map entry in query){
        output.add(ConfigListItem(entry));
      }
    }
    return output;
  }

  Widget ConfigListItem(Map<String, dynamic> entry) {
    ExperimentSettings currentConfig = BackEnd.of(context).getSetting();
    var loadedConfig = ExperimentSettings.fromDBMap(entry);
    print(identical(currentConfig, loadedConfig));
    print(currentConfig);
    print(loadedConfig);
    return Container(
        color: currentConfig != null && currentConfig.hasSameParameters(loadedConfig)
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
                entry["type"] == "Voltammetry" ?
                  "Initial Voltage: " +
                  entry["initialVoltage"].toString() +
                  ", " +
                  "Vertex Voltage: " +
                  entry["vertexVoltage"].toString() +
                  ", " +
                  "Final Voltage: " +
                  entry["finalVoltage"].toString() ://split here
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
            _onSelected(ExperimentSettings.fromDBMap(entry));
            Navigator.pop(context);
          },
        ));
  }
}
