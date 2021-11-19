import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  AmperometrySettings testAmperometryConfig = AmperometrySettings(
    runtime: 5,
    sampleInterval: .01,
    initialVoltage: 0,
    gainSetting: GainSettings.nA10,
    electrode: Electrode.pseudoref,
  );

  VoltammetrySettings testVoltammetryConfig = VoltammetrySettings(
    initialVoltage: 0,
    vertexVoltage: .5,
    finalVoltage: -.5,
    scanRate: .3,
    sweepSegments: 6,
    sampleInterval: .01,
    gainSetting: GainSettings.uA1,
    electrode: Electrode.calomel,
  );

  //test("toDBMap converts amperometry config into DB format", expect(actual, matcher))
}