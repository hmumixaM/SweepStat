import 'package:flutter/material.dart';
import 'ValueInput.dart';
import 'DropDownInput.dart';
import '../screen/StateWidget.dart';

// Helper functions for checking if correct range
String voltValid(String num) {
  double n = double.parse(num);
  return (n >= -1.5 && n <= 1.5) ? null : "Enter a number between -1.5 and 1.5";
}

String segmentsValid(String num) {
  double n = double.parse(num);
  return n.floor() == n  && n > 0 ? null : "Must be an integer greater than 0";
}

class EndDrawerPage extends StatelessWidget {
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
                ValueInput(
                    'Initial Voltage (V)',
                        (double d) => {BackEnd.of(context).newArgument(d)},
                    BackEnd.of(context).state.testNum.toString(),
                    voltValid),
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
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Vertex Voltage (V)',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Final Voltage (V)',
                  ),
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
                    onPressed: () {},
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