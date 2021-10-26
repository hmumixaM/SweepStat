import 'package:flutter/cupertino.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'package:sweep_stat_app/experiment/Experiment.dart';


class CoreState {
  final ExperimentSettings settings;
  final Experiment experiment;
  final String testString;
  final double testNum;

  const CoreState({
    this.settings,
    this.experiment,
    this.testString = "hello world",
    this.testNum = 0.5,
  });

  CoreState copy({
    ExperimentSettings settings,
    Experiment experiment,
    String testString,
    double testNum,
  }) =>
      CoreState(
        settings: settings ?? this.settings,
        experiment: experiment ?? this.experiment,
        testString: testString ?? this.testString,
        testNum: testNum ?? this.testNum,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CoreState &&
              runtimeType == other.runtimeType &&
              settings == other.settings &&
              experiment == other.experiment &&
              testNum == other.testNum &&
              testString == other.testString;

  @override
  int get hashCode => settings.hashCode ^ experiment.hashCode ^ testNum.hashCode ^ testString.hashCode;
}
