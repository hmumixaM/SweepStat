import 'package:flutter/material.dart';
import 'package:sweep_stat_app/bluetooth/BluetoothProcessing.dart';
import 'package:sweep_stat_app/bluetooth/SweepStatBTConnection.dart';
import '../experiment/ExperimentSettings.dart';
import '../experiment/Experiment.dart';
import 'CoreState.dart';

class StateWidget extends StatefulWidget {
  final Widget child;

  const StateWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  CoreState state = CoreState(
      experiment: Experiment(),
      settings: VoltammetrySettings(
        initialVoltage: 0.0,
        vertexVoltage: 0.5,
        finalVoltage: 0.0,
        sampleInterval: .1,
        sweepSegments: 2,
        scanRate: 0.5,
        gainSetting: GainSettings.uA1,
        electrode: Electrode.calomel,
      ),
      sweepStatBTConnection: null,
      bluetoothProcessing: BluetoothProcessing());

  ExperimentSettings getSetting() {
    return state.settings;
  }

  Experiment getExp() {
    return state.experiment;
  }

  SweepStatBTConnection getBT() {
    return state.sweepStatBTConnection;
  }

  BluetoothProcessing getProcess() {
    return state.bluetoothProcessing;
  }

  void newSettings(ExperimentSettings settings) {
    final newState = state.copy(settings: settings);

    setState(() => state = newState);
  }

  void newExperiment(Experiment experiment) {
    final newState = state.copy(experiment: experiment);

    setState(() => state = newState);
  }

  void newBluetoothConnection(SweepStatBTConnection sweepStatBTConnection) {
    final newState = state.copy(sweepStatBTConnection: sweepStatBTConnection);

    setState(() => state = newState);
  }

  void clearBluetoothConnection() {
    final newState = CoreState(
        settings: state.settings,
        experiment: state.experiment,
        sweepStatBTConnection: null,
        bluetoothProcessing: state.bluetoothProcessing);

    setState(() => state = newState);
  }

  void newBluetoothProcessing(BluetoothProcessing bluetoothProcessing) {
    final newState = state.copy(bluetoothProcessing: bluetoothProcessing);

    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) => BackEnd(
        child: widget.child,
        state: state,
        stateWidget: this,
      );
}

class BackEnd extends InheritedWidget {
  final CoreState state;
  final _StateWidgetState stateWidget;

  const BackEnd({
    Key key,
    @required Widget child,
    @required this.state,
    @required this.stateWidget,
  }) : super(key: key, child: child);

  static _StateWidgetState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BackEnd>().stateWidget;

  @override
  bool updateShouldNotify(BackEnd oldWidget) => oldWidget.state != state;
}
