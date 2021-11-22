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
  var returnable = [];
  for(int i = 0; i < numPoints; i++){
    double y = i >= numPoints/2 ? i*.02 : i*.01*numPoints - i*.02;
    returnable.add(FlSpot(i*.01, y));
  }

  return returnable;
}