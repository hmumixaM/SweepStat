import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweep_stat_app/file_management/file_manager.dart';
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
    BackEnd.of(context).getSetting() != null
        && BackEnd.of(context).getSetting().runtimeType.toString() == 'Amperometry'
        ? 'Amperometry'
        : 'Voltammetry';
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (saveSettings()) Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async{
                if (saveSettings())
                  buildAlertDialog(context).then((fileName) async{
                    Database db = await DBManager.startDBConnection();
                    await DBManager.addObject(db, EntryType.config, BackEnd.of(context).getSetting().toDBMap(fileName));
                    var query = await DBManager.queryEntireTable(db, EntryType.config);
                    print(query);
                    DBManager.closeDBConnection(db);
                  });
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
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
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          AmperometrySettings
                  ? BackEnd.of(context).state.settings.initialVoltage.toString()
                  : '',
              voltValid,
              'The voltage that SweepStat started with.'),
          ValueInput(
              'Sample Interval (V)',
              (double d) =>
                  {(_settings as AmperometrySettings).sampleInterval = d},
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          AmperometrySettings
                  ? BackEnd.of(context).state.settings.sampleInterval.toString()
                  : '',
              voltValid, 'The step of voltage when voltage changes.'),
          ValueInput(
              'Run time (S)',
              (double d) => {(_settings as AmperometrySettings).runtime = d},
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          AmperometrySettings
                  ? (BackEnd.of(context).state.settings as AmperometrySettings)
                      .runtime
                      .toString()
                  : '',
              segmentsValid, 'The total time to run the experiment.'),
          DropDownInput(
            labelStrings: ['10 nA/V', '1 uA/V', '1 mA/V'],
            values: GainSettings.values.toList(),
            hint: 'Select Gain Setting',
            initialVal: BackEnd.of(context).state.settings != null &&
                    BackEnd.of(context).state.settings.runtimeType ==
                        AmperometrySettings
                ? BackEnd.of(context).state.settings.gainSetting
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
            initialVal: BackEnd.of(context).state.settings != null &&
                    BackEnd.of(context).state.settings.runtimeType ==
                        AmperometrySettings
                ? BackEnd.of(context).state.settings.electrode
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ValueInput(
              'Initial Voltage (V)',
              (double d) =>
                  {(_settings as VoltammetrySettings).initialVoltage = d},
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).state.settings as VoltammetrySettings)
                      .initialVoltage
                      .toString()
                  : '',
              voltValid, 'The voltage that SweepStat started with. Recommend default to be 0V.'),
          ValueInput(
              'Vertex Voltage (V)',
              (double d) =>
                  {(_settings as VoltammetrySettings).vertexVoltage = d},
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).state.settings as VoltammetrySettings)
                      .vertexVoltage
                      .toString()
                  : '',
              voltValid, 'The maximum voltage that sweepstat will take. Recommend default to be 1V.'),
          ValueInput(
              'Final Voltage (V)',
              (double d) =>
                  {(_settings as VoltammetrySettings).finalVoltage = d},
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).state.settings as VoltammetrySettings)
                      .finalVoltage
                      .toString()
                  : '',
              voltValid, 'The final voltage where sweepstat end with. Recommend default to be same as the initial volatge.'),
          ValueInput(
              'Scan Rate (V/s)',
              (double d) => {(_settings as VoltammetrySettings).scanRate = d},
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).state.settings as VoltammetrySettings)
                      .scanRate
                      .toString()
                  : '',
              voltValid, 'The rate of scanning current.'),
          ValueInput(
              'Sweep Segments',
              (double d) =>
                  {(_settings as VoltammetrySettings).sweepSegments = d.floor()},
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).state.settings as VoltammetrySettings)
                      .sweepSegments
                      .toString()
                  : '',
              segmentsValid, 'Number of segments to do.'),
          ValueInput(
              'Sample Interval (V)',
              (double d) =>
                  {(_settings as VoltammetrySettings).sampleInterval = d},
              BackEnd.of(context).state.settings != null &&
                      BackEnd.of(context).state.settings.runtimeType ==
                          VoltammetrySettings
                  ? (BackEnd.of(context).state.settings as VoltammetrySettings)
                      .sampleInterval
                      .toString()
                  : '',
              voltValid, 'The sample interval.'),
          DropDownInput(
            labelStrings: ['10 nA/V', '1 uA/V', '1 mA/V'],
            values: GainSettings.values.toList(),
            hint: 'Select Gain Setting',
            initialVal: BackEnd.of(context).state.settings != null &&
                    BackEnd.of(context).state.settings.runtimeType ==
                        VoltammetrySettings
                ? BackEnd.of(context).state.settings.gainSetting
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
            initialVal: BackEnd.of(context).state.settings != null &&
                    BackEnd.of(context).state.settings.runtimeType ==
                        VoltammetrySettings
                ? BackEnd.of(context).state.settings.electrode
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
