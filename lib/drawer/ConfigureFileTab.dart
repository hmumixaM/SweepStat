import 'package:flutter/material.dart';
import 'package:sweep_stat_app/drawer/ConfigureItem.dart';
import 'package:sweep_stat_app/end_drawer/EndDrawerPage.dart';

class ConfigureFileTab extends StatefulWidget {
  //final String name_entries;
  final double initialV;
  final double vertexV;
  final double finalV;
  ConfigureFileTab(
      {Key key,
      @required this.initialV,
      @required this.vertexV,
      @required this.finalV})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConfigureFileTab();
  }
}

class _ConfigureFileTab extends State<ConfigureFileTab> {
  @override
  Widget build(BuildContext context) {
    /* final List<String> nameList = <String>[
      'Configuration 1',
      'Configuration 2',
      'Configuration 3',
      'Configuration 4'
    ];*/
    List<double> initialVList = <double>[1, 2, 3, 12, 2, 0, 1, 1.5, 2.5, 3];
    List<double> vertexVList = <double>[4, 5, 6, 23, 2, 0, 1, 1.5, 2.5, 3];
    List<double> finalVList = <double>[7, 8, 9, 30, 2, 0, 1, 1.5, 2.5, 3];
    List<String> name_entries = <String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10'
    ];
    List<Config> ConfigList = <Config>[];
    initialVList.insert(0, widget.initialV);
    vertexVList.insert(0, widget.vertexV);
    finalVList.insert(0, widget.finalV);
/*    name_entries.add(name_entries.length.toString());*/

    for (int i = 0; i < initialVList.length; i++) {
      Config newConfig = new Config(
        name: 'Configuration ' + (i + 1).toString(),
        initialV: initialVList[i],
        vertexV: vertexVList[i],
        finalV: finalVList[i],
      );
      ConfigList.add(newConfig);
    }
    ;

/*
    ConfigList.add(new Config(name: 'Configuration ' + (name_entries.length).toString(),
      initialV: widget.initialV,
      vertexV: widget.vertexV,
      finalV: widget.finalV,));
*/

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(75, 156, 211, 0.8),
        title: const Text('Configuration List'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: name_entries.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildConfigList(ConfigList[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      /*ListTile(
        title: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          child: Text('Configuration ' + (name_entries.length).toString()),
        ),
        subtitle: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
          child: Text("Type of Experiment: CV\n" +
              "Initial Voltage: " +
                widget.initialV.toString() +
              ", " +
              "Vertex Voltage: " +
    widget.vertexV.toString() +
              ", " +
              "Final Voltage: " +
    widget.finalV.toString()+ " Scan Rate: 20V/s,\n Sweep Segments: 20V, Sample Interval: 20V, Run Time: 30s",
              style: TextStyle(height: 2)),

        ),
    )*/
    );
  }
}

Widget _buildConfigList(Config items) {
  return ListTile(
    title: Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Text(items.name),
    ),
    subtitle: Padding(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
      child: Text(
          "Type of Experiment: CV\n" +
              "Initial Voltage: " +
              items.initialV.toString() +
              ", " +
              "Vertex Voltage: " +
              items.vertexV.toString() +
              ", " +
              "Final Voltage: " +
              items.finalV.toString() +
              " Scan Rate: 0.05V/s,\n Sweep Segments: 4V, Sample Interval: 0.01V, Run Time: 30s",
          style: TextStyle(height: 2)),
    ),
    onTap: () => {},
  );
}
