import 'package:flutter/material.dart';
import 'package:sweep_stat_app/drawer/ConfigureItem.dart';
import 'package:sweep_stat_app/drawer/ConfigureFileTab.dart';

class EndDrawerPage extends StatelessWidget {
  final int initialV;
  final int vertexV;
  final int finalV;
  EndDrawerPage({Key key, @required this.initialV, @required this.vertexV, @required this.finalV}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
                child: Text(
                  'Experiment Configuration',
                  textScaleFactor: 2,
                )),
          ),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Initial Voltage (V)',
                  ),
                  validator: (String value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  initialValue: initialV.toString(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Vertex Voltage (V)',
                  ),
                  initialValue: vertexV.toString(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Final Voltage (V)',
                  ),
                  initialValue: finalV.toString(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Scan Rate (V/s)',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Sweep Segments',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Sample Interval (V)',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Run time (S)',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Apply'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfigureFileTab(),
                      ),
                    );},
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}