import 'package:flutter/cupertino.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'package:sweep_stat_app/experiment/Experiment.dart';


class CoreState {
  final ExperimentSettings settings;
  final Experiment experiment;
  final String testString;

  const CoreState({
    this.settings,
    this.experiment,
    this.testString = "hello world",
  });

  CoreState copy({
    ExperimentSettings settings,
    Experiment experiment,
  }) =>
      CoreState(
        settings: settings ?? this.settings,
        experiment: experiment ?? this.experiment,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CoreState &&
              runtimeType == other.runtimeType &&
              settings == other.settings &&
              experiment == other.experiment;

  @override
  int get hashCode => settings.hashCode ^ experiment.hashCode;
}
