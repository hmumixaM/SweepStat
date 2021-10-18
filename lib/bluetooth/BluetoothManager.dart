import 'dart:async';
import 'package:sweep_stat_app/bluetooth/BluetoothConnectionSim.dart';

class BluetoothManager{
  static List<BluetoothConnectionSim> tempList = [BluetoothConnectionSim("SweepStat 1"), BluetoothConnectionSim("SweepStat 2"), BluetoothConnectionSim("SweepStat 3")];
  static BluetoothConnectionSim sim;

  static void connect(BluetoothConnectionSim s){
    if(sim != null){
      sim.disconnect();
    }
    sim = s;
    s.connect();
  }

  static void disconnect(BluetoothConnectionSim s){
    s.disconnect();
    if(sim == s){
      sim = null;
    }
  }
}