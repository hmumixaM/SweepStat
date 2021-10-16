import 'package:flutter/material.dart';

class ConfigureFileTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigureFileTab();
  }
}

class _ConfigureFileTab extends State<ConfigureFileTab> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    //final List<int> colorCodes = <int>[600, 500, 100];
    return new Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(75, 156, 211, 0.8),
            title: const Text('Configuration List'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Text('Configuration $index'),
          ),
                subtitle: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    child: Text("Type of Experiment: CV\n"
                "Initial Voltage: -0.5V, Vertex Voltage: 1V, Final Voltage: 0.5V, Scan Rate: 20V/s,\n Sweep Segments: 20V, Sample Interval: 20V, Run Time: 30s",
                          style: TextStyle(height: 2)),

          ),

          onTap: () => {},
        );

      },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
    )
    );
  }
}