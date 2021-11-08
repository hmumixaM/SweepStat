import 'package:sweep_stat_app/bluetooth/BluetoothProcessing.dart';
import 'package:sweep_stat_app/bluetooth/SweepStatBTConnection.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'package:sweep_stat_app/experiment/Experiment.dart';

class CoreState {
  final ExperimentSettings settings;
  final Experiment experiment;
  final SweepStatBTConnection sweepStatBTConnection;
  final BluetoothProcessing bluetoothProcessing;

  const CoreState({
    this.settings,
    this.experiment,
    this.sweepStatBTConnection,
    this.bluetoothProcessing,
  });

  CoreState copy({
    ExperimentSettings settings,
    Experiment experiment,
    SweepStatBTConnection sweepStatBTConnection,
    BluetoothProcessing bluetoothProcessing,
  }) =>
      CoreState(
        settings: settings ?? this.settings,
        experiment: experiment ?? this.experiment,
        sweepStatBTConnection: sweepStatBTConnection ?? this.sweepStatBTConnection,
        bluetoothProcessing: bluetoothProcessing ?? this.bluetoothProcessing,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CoreState &&
              runtimeType == other.runtimeType &&
              settings == other.settings &&
              experiment == other.experiment &&
              sweepStatBTConnection == other.sweepStatBTConnection &&
              bluetoothProcessing == other.bluetoothProcessing;

  @override
  int get hashCode => settings.hashCode ^ experiment.hashCode ^ sweepStatBTConnection.hashCode ^ bluetoothProcessing.hashCode;
}
