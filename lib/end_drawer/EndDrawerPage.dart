import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import 'ValueInput.dart';
import 'DropDownInput.dart';
import '../screen/StateWidget.dart';
import '../experiment/ExperimentSettings.dart';

// Helper functions for checking if correct range
String voltValid(String num) {
  double n = double.parse(num);
  return (n >= -1.5 && n <= 1.5) ? null : "Enter a number between -1.5 and 1.5";
}

String segmentsValid(String num) {
  double n = double.parse(num);
  return n.floor() == n && n > 0 ? null : "Must be an integer greater than 0";
}

class EndDrawerPage extends StatefulWidget {
  State<StatefulWidget> createState() => _EndDrawerpage();
}

class _EndDrawerpage extends State<EndDrawerPage> {
  String _mode = 'Voltammetry';
  final _fromKeyA = GlobalKey<FormState>();
  final _fromKeyV = GlobalKey<FormState>();
  ExperimentSettings _settings;

  void modeChange(String mode) {
    setState(() {
      _settings = null;
      _mode = mode;
    });
  }

  bool saveSettings() {
    if (_mode == "Amperometry") {
      if (_fromKeyA.currentState.validate()) {
        _settings = AmperometrySettings();
        _fromKeyA.currentState.save();
      } else
        return false;
    } else {
      if (_fromKeyV.currentState.validate()) {
        _settings = VoltammetrySettings();
        _fromKeyV.currentState.save();
      } else
        return false;
    }
    BackEnd.of(context).newSettings(_settings);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    BackEnd.of(context).getSetting() != null &&
            BackEnd.of(context).getSetting().runtimeType.toString() ==
                'Amperometry'
        ? 'Amperometry'
        : 'Voltammetry';
    return Drawer(
        //child: SingleChildScrollView(
        child: ListView(padding: EdgeInsets.zero, children: [
      Container(
          height: 80.0,
          //width: 100.0,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(75, 156, 211, 0.8),
            ),
            child: Center(
                child: Text(
              'Experiment Configuration',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            )),
          )),
      new DropDownInput(
        labelStrings: ["Amperometry", "Voltammetry"],
        values: ["Amperometry", "Voltammetry"],
        hint: "Select mode of experiment",
        initialVal: _mode,
        callback: () {},
        onChange: modeChange,
      ),
      _mode == "Amperometry"
          ? buildAmperometryForm(context)
          : buildVoltammetryForm(context),
      Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(75, 156, 211, 0.8),
                minimumSize: Size(
                    120, 35), // takes postional arguments as width and height
              ),
              onPressed: () {
                if (saveSettings()) Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(75, 156, 211, 0.8),
                minimumSize: Size(
                    120, 35), // takes postional arguments as width and height
              ),
              onPressed: () async {
                if (saveSettings())
                  buildAlertDialog(context).then((fileName) async {
                    Database db = await DBManager.startDBConnection();
                    await DBManager.addObject(db, EntryType.config,
                        BackEnd.of(context).getSetting().toDBMap(fileName));
                    var query =
                        await DBManager.queryEntireTable(db, EntryType.config);
                    print(query);
                    DBManager.closeDBConnection(db);
                  });
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    ]));
  }

  Future<String> buildAlertDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Input the file name: "),
              content: TextField(
                controller: controller,
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 0.5,
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  elevation: 0.5,
                  child: Text("Save"),
                  onPressed: () {
                    Navigator.of(context).pop(controller.text.toString());
                  },
                )
              ]);
        });
  }

  Widget buildAmperometryForm(BuildContext context) {
    return Form(
      key: _fromKeyA,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueInput(
              'Initial Voltage (V)',
              (double d) =>
                  {(_settings as AmperometrySettings).initialVoltage = d},
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          AmperometrySettings
                  ? BackEnd.of(context).getSetting().initialVoltage.toString()
                  : '',
              voltValid,
              'The voltage that SweepStat started with.'),
          ValueInput(
              'Sample Interval (V)',
              (double d) =>
                  {(_settings as AmperometrySettings).sampleInterval = d},
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          AmperometrySettings
                  ? BackEnd.of(context).getSetting().sampleInterval.toString()
                  : '',
              voltValid,
              'The step of voltage when voltage changes.'),
          ValueInput(
              'Run time (S)',
              (double d) => {(_settings as AmperometrySettings).runtime = d},
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          AmperometrySettings
                  ? (BackEnd.of(context).getSetting() as AmperometrySettings)
                      .runtime
                      .toString()
                  : '',
              segmentsValid,
              'The total time to run the experiment.'),
          DropDownInput(
            labelStrings: ['10 nA/V', '1 uA/V', '1 mA/V'],
            values: GainSettings.values.toList(),
            hint: 'Select Gain Setting',
            initialVal: BackEnd.of(context).getSetting() != null &&
                    BackEnd.of(context).getSetting().runtimeType ==
                        AmperometrySettings
                ? BackEnd.of(context).getSetting().gainSetting
                : null,
            callback: (GainSettings val) {
              (_settings as AmperometrySettings).gainSetting = val;
            },
          ),
          DropDownInput(
            labelStrings: [
              'Pseudo-Reference Electrode',
              'Silver/Silver Chloride Electrode',
              'Saturated Calomel',
              'Standard Hydrogen Electrode'
            ],
            values: Electrode.values.toList(),
            hint: 'Select Electrode',
            initialVal: BackEnd.of(context).getSetting() != null &&
                    BackEnd.of(context).getSetting().runtimeType ==
                        AmperometrySettings
                ? BackEnd.of(context).getSetting().electrode
                : null,
            callback: (Electrode val) {
              (_settings as AmperometrySettings).electrode = val;
            },
          ),
        ],
      ),
    );
  }

  Widget buildVoltammetryForm(BuildContext context) {
    return Form(
      key: _fromKeyV,
      child: Column(
        children: <Widget>[
          ValueInput(
              'Initial Voltage (V)',
              (double d) =>
                  {(_settings as VoltammetrySettings).initialVoltage = d},
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).getSetting() as VoltammetrySettings)
                      .initialVoltage
                      .toString()
                  : '',
              voltValid,
              'This is the potential that your experiment will start at, and it can be positive or negative. The recommended initial voltage value is based on experiments using ferrocene derivatives\n\nRecommend Value: 0 V\n\nRange: -1.5 V to 1.5 V'),
          ValueInput(
              'Vertex Voltage (V)',
              (double d) =>
                  {(_settings as VoltammetrySettings).vertexVoltage = d},
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).getSetting() as VoltammetrySettings)
                      .vertexVoltage
                      .toString()
                  : '',
              voltValid,
              'This is the potential where the cyclic voltammetry experiment will turn around and begin moving in the opposite potential direction. It can be positive or negative. The recommended vertex voltage value is based on experiments using ferrocene derivatives.\n\nRecommend Value: 0.5V\n\nRange: -1.5 V to 1.5 V'),
          ValueInput(
              'Final Voltage (V)',
              (double d) =>
                  {(_settings as VoltammetrySettings).finalVoltage = d},
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).getSetting() as VoltammetrySettings)
                      .finalVoltage
                      .toString()
                  : '',
              voltValid,
              'This is the potential that your experiment will end at, and it can be positive or negative. The recommended final voltage value is based on experiments using ferrocene derivatives.\n\nRecommend Value: 0V\n\nRange: -1.5 V to 1.5 V'),
          ValueInput(
              'Scan Rate (V/s)',
              (double d) => {(_settings as VoltammetrySettings).scanRate = d},
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).getSetting() as VoltammetrySettings)
                      .scanRate
                      .toString()
                  : '',
              voltValid,
              'his is essentially how fast or slow your experiment moves, it how many volts the Sweepstat will move per second. The scan rate value is based on experiments using ferrocene derivatives.\n\nRecommend Value: 0.05 V/s\n\nRange: Integer great than 0, but typically somewhere between 0.001 V/s to 1 V/s'),
          ValueInput(
              'Sweep Segments',
              (double d) => {
                    (_settings as VoltammetrySettings).sweepSegments = d.floor()
                  },
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).getSetting() as VoltammetrySettings)
                      .sweepSegments
                      .toString()
                  : '',
              segmentsValid,
              'This is the number of segments (i.e., one segment is moving from the initial voltage to the vertex voltage or moving from the vertex voltage to the final voltage) that the Sweepstat will perform. Two segments are considered to be one complete scan.\n\nRecommend Value: 6\n\nRange: Integer greater than 0.'),
          ValueInput(
              'Sample Interval (V)',
              (double d) =>
                  {(_settings as VoltammetrySettings).sampleInterval = d},
              BackEnd.of(context).getSetting() != null &&
                      BackEnd.of(context).getSetting().runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).getSetting() as VoltammetrySettings)
                      .sampleInterval
                      .toString()
                  : '',
              voltValid,
              'This the frequency at which the data will be collected (i.e., a point will be recorded every 0.01 V using the recommended value). The smaller the sample interval, the larger the file will be.\n\nRecommend Value: 0.01 V\n\nRange: Integer greater than 0'),
          DropDownInput(
            labelStrings: ['10 nA/V', '1 uA/V', '1 mA/V'],
            values: GainSettings.values.toList(),
            hint: 'Select Gain Setting',
            initialVal: BackEnd.of(context).getSetting() != null &&
                    BackEnd.of(context).getSetting().runtimeType ==
                        VoltammetrySettings
                ? BackEnd.of(context).getSetting().gainSetting
                : null,
            callback: (GainSettings val) {
              (_settings as VoltammetrySettings).gainSetting = val;
            },
          ),
          DropDownInput(
            labelStrings: [
              'Pseudo-Reference Electrode',
              'Silver/Silver Chloride Electrode',
              'Saturated Calomel',
              'Standard Hydrogen Electrode'
            ],
            values: Electrode.values.toList(),
            hint: 'Select Electrode',
            initialVal: BackEnd.of(context).getSetting() != null &&
                    BackEnd.of(context).getSetting().runtimeType ==
                        VoltammetrySettings
                ? BackEnd.of(context).getSetting().electrode
                : null,
            callback: (Electrode val) {
              (_settings as VoltammetrySettings).electrode = val;
            },
          ),
        ],
      ),
    );
  }
}
