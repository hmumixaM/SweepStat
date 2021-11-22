import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweep_stat_app/experiment/Experiment.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';

void main() async{
  ExperimentSettings validCVSettings = VoltammetrySettings(
    initialVoltage: .5,
    vertexVoltage: 2.5,
    finalVoltage: .5,
    scanRate: .2,
    sampleInterval: .01,
    sweepSegments: 6,
    gainSetting: GainSettings.uA1,
    electrode: Electrode.silver,
  );

  Experiment validExperiment = Experiment(validCVSettings);
  validExperiment.dataL = smoothDataGenerator(200);

  print(validExperiment.toString());
}


List<FlSpot> smoothDataGenerator(int numPoints){
  List<FlSpot> returnable = [];
  for(int i = 0; i < numPoints; i++){
    returnable.add(FlSpot(i*.01, sin(i*.01)));
  }

  return returnable;
}