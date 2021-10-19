import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sweep_stat_app/bluetooth/BluetoothConnectionSim.dart';
import 'package:flutter/material.dart';

class BluetoothManager {
  static BluetoothConnectionSim sim;
  static FlutterBlue blueInstance = FlutterBlue.instance;
  static List<BluetoothDevice> deviceList;
  static BluetoothDevice currentDevice;

  //needs error handling for devices without bluetooth support
  static void scan() {
    var foundDevices = [];

    blueInstance.startScan(timeout: Duration(seconds: 4));
    blueInstance.scanResults.listen((results) {
      for (ScanResult result in results) {
        foundDevices.add(result.device);
      }
    });

    blueInstance.stopScan();
    deviceList = foundDevices;
  }

  //needs error handling in case of connection failure
  static void connect(BluetoothDevice d) async{
    await d.connect();
    currentDevice = d;
  }

  //need to find out whether or not this can fail
  static void disconnect(BluetoothDevice d){
    d.disconnect();
  }

  static Future<bool> isCapable() async{
    return await blueInstance.isOn;
  }

  static Future<Widget> alertDeviceBluetoothIncapable(BuildContext context) async{
    return  await showDialog<AlertDialog>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connection Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('This device either does not support Bluetooth or does not have it enabled.'),
                Text('If this device supports Bluetooth, please enable it for the SweepStat app in your settings menu and try again.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<Widget> alertNoBluetoothDevicesFound(BuildContext context) async{
    return  await showDialog<AlertDialog>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connection Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("We can't detect any nearby SweepStats."),
                Text('Make sure your SweepStat is within a few meters of this device and is powered on.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
