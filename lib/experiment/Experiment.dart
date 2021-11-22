import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'ExperimentSettings.dart';
import 'package:share_plus/share_plus.dart';

class Experiment {
  final ExperimentSettings settings;
  List<FlSpot> dataL = [FlSpot(0,0)];
  List<FlSpot> dataR = [FlSpot(0,0)];
  Directory experimentDir;
  bool isExperimentInProgress = false;
  List<Function> listener = [];

  Experiment(this.settings);

  void addL(FlSpot a) {
    dataL.add(a);
    notifyListener();
  }

  void addR(FlSpot a) {
    dataR.add(a);
    notifyListener();
  }

  void addListener(Function update) {
    listener.add(update);
  }

  void notifyListener() {
    for (Function listen in listener) {
      listen(this);
    }
  }

  List<String> dataToString() {
    try {
      List<FlSpot> dataRCopy = [];
      dataRCopy.addAll(dataR);
      dataRCopy.insertAll(0, dataL);
      List<String> stringified = dataRCopy.map((dataPoint) => "${dataPoint.x}, ${dataPoint.y}").toList();
      stringified.insert(0, "potential, current");
      return stringified;
    } catch (IOException) {
      return null;
    }
  }


  @override
  String toString() {
    String returnString;
    if (this.settings is VoltammetrySettings){
      VoltammetrySettings v = this.settings;
      returnString = 'Cyclic Voltammetry\n' +
          'Gain Setting: ' + v.gainSetting.toString().split('.').last + '\n' +
          'Ref. Electrode: ' + v.electrode.toString().split('.').last + '\n\n' +
          'Init E (V) = ' + v.initialVoltage.toString() + '\n' +
          'Vertex E (V) = ' + v.vertexVoltage.toString() + '\n' +
          'Final E (V) = ' + v.finalVoltage.toString() + '\n' +
          'Scan Rate (V/s) = ' + v.scanRate.toString() + '\n' +
          'Sweep Segments = ' + v.sweepSegments.toString() + '\n' +
          'Sample Interval (V) = ' + v.sampleInterval.toString() + '\n\n';
    } else {
      AmperometrySettings a = this.settings;
      returnString = 'Amperometry\n' +
          'Gain Setting: ' + a.gainSetting.toString().split('.').last + '\n' +
          'Ref. Electrode: ' + a.electrode.toString().split('.').last + '\n\n' +
          'Initial E (V) = ' + a.initialVoltage.toString() + '\n' +
          'Sample Interval (V) = ' + a.sampleInterval.toString() + '\n' +
          'Runtime (S) = ' + a.runtime.toString() + '\n\n';
    }
    returnString += this.dataToString().join('\n');
    return returnString;
  }

  /*static Future<Experiment> loadFromFile(File f, String expType) async{
    List<String> lines = await f.readAsLines();
    Experiment e;
    int startLine;
    if (expType == 'CV'){
      VoltammetrySettings v = new VoltammetrySettings();
      v.gainSetting = GainSettings.values.firstWhere((val)=> val.toString().split('.').last == lines[1].split(': ').last);
      v.electrode = Electrode.values.firstWhere((val)=> val.toString().split('.').last == lines[2].split(': ').last);
      v.initialVoltage = double.parse(lines[4].split(' = ').last);
      v.vertexVoltage = double.parse(lines[5].split(' = ').last);
      v.finalVoltage = double.parse(lines[6].split(' = ').last);
      v.scanRate = double.parse(lines[7].split(' = ').last);
      v.sweepSegments = int.parse(lines[8].split(' = ').last);
      v.sampleInterval = double.parse(lines[9].split(' = ').last);
      e = new Experiment(v);
      startLine = 12;

    } else {
      AmperometrySettings a = new AmperometrySettings();
      a.gainSetting = GainSettings.values.firstWhere((val)=> val.toString().split('.').last == lines[1].split(': ').last);
      a.electrode = Electrode.values.firstWhere((val)=> val.toString().split('.').last == lines[2].split(': ').last);
      a.initialVoltage = double.parse(lines[4].split(' = ').last);
      a.sampleInterval = double.parse(lines[5].split(' = ').last);
      a.runtime = double.parse(lines[6].split(' = ').last);
      e = new Experiment(a);
      startLine = 9;
    }

    List<FlSpot> dataL = [];
    List<FlSpot> dataR = [];
    bool isRisingVoltage = true;
    for(int i = startLine; i < lines.length; i++){
      double potential = double.parse(lines[i].split(', ').first);
      double current = double.parse(lines[i].split(', ').last);
      FlSpot point = FlSpot(potential, current);
      if (e.settings is VoltammetrySettings && isRisingVoltage && potential >= (e.settings as VoltammetrySettings).vertexVoltage) isRisingVoltage = false;
      if (isRisingVoltage){
        dataL.add(point);
      } else {
        dataR.add(point);
      }
    }
    e.dataL= dataL;
    e.dataR = dataR;
    return e;
  }*/

  Future<void> shareFile(String name) async{
    var path = (await getExternalStorageDirectory()).path; //switch to getApplicationDocumentsDirectory for release
    path  = join(path, "$name.csv");
    var file = File(path);

    file = await file.writeAsString(toString());
    await Share.shareFiles([path]);
    //delete file?
  }
}
