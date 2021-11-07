import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../experiment/Experiment.dart';
import '../experiment/ExperimentSettings.dart';
import '../screen/StateWidget.dart';

class BluetoothProcessing {
  Timer expTimeout;
  Utf8Decoder dec = Utf8Decoder();
  bool isExperimentInProgress = false;
  bool isRisingVoltage = true;
  bool clearedPlaceholderR = false;
  bool clearedPlaceholderL = false;
  String previousPart = "";
  BuildContext context;


  void startExperiment(BuildContext context) {
    if (BackEnd.of(context).getBT() == null) {
      print("not connected");
      return;
    }

    expTimeout = Timer(Duration(seconds: 5), (){
      if (BackEnd.of(context).getExp().dataL.length == 1 && BackEnd.of(context).getExp().dataR.length == 1){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Experiment Timeout, Please Retry')));
        BackEnd.of(context).getExp().isExperimentInProgress = false;

      }
      expTimeout = null;
    });
    Experiment experiment = Experiment(BackEnd.of(context).getSetting());
    BackEnd.of(context).newExperiment(experiment);
    print(BackEnd.of(context).getSetting().toBTString());
    BackEnd.of(context).getBT().writeToSweepStat(BackEnd.of(context).getSetting().toBTString());
    BackEnd.of(context).getExp().isExperimentInProgress = true;
    print("sent bt");
  }

  void acceptBTData(List<int> intMessage) {
    print("A callback for processing");
    String message = dec.convert(intMessage);
    if (message == "") return;
    if (message.contains('Z')){
      List<String> parts = message.split('Z');
      if (parts.length > 2){
        plotBTPoint(previousPart + parts[0]);
        plotBTPoint(parts[1]);
        previousPart = parts[2];
      } else {
        plotBTPoint(previousPart + parts[0]);
        previousPart = parts[1];
      }
      if (previousPart == '\$') {
        if (expTimeout != null) {
          expTimeout.cancel();
          expTimeout = null;
        }
        BackEnd.of(context).getExp().isExperimentInProgress = false;
      }
    } else {
      previousPart += message;
      return;
    }
  }

  void plotBTPoint(String message){
    //TODO: Parse actual data from the SweepStat
    List<double> data = parseSweepStatData(message);
    double volt = data[1];
    double charge = data[2];
    /*List<String> parts = message.split(',');
    double volt = double.parse(parts[1].substring(2));
    double charge = double.parse(parts[2].substring(2, parts[2].length - 1));*/
    if (isRisingVoltage && volt >=
        (BackEnd.of(context).getExp().settings as VoltammetrySettings).vertexVoltage) isRisingVoltage = false;
    // if (mounted) {
      if (isRisingVoltage) {
        BackEnd.of(context).getExp().dataL.add(new FlSpot(volt, charge));
        if (!clearedPlaceholderL){
          BackEnd.of(context).getExp().dataL.removeAt(0);
          clearedPlaceholderL = true;
        }
      } else {
        BackEnd.of(context).getExp().dataR.add(new FlSpot(volt, charge));
        if (!clearedPlaceholderR){
          BackEnd.of(context).getExp().dataR.removeAt(0);
          clearedPlaceholderR = true;
        }
      }
    // }

  }

  List<double> parseSweepStatData(String data){
    data = data.substring(1);
    List<String> vSplit = data.split('V');
    List<String> cSplit = vSplit[1].split('C');
    return [vSplit[0], ...cSplit].map((str)=>double.parse(str)).toList();

  }

  void onBTDisconnect(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(BackEnd.of(context).getBT().device.name + ' disconnected')
    ));
    BackEnd.of(context).newBluetoothConnection(null);
  }
}