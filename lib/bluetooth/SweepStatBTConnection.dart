import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

const String sweepstatServiceUUID = "0000FFE0-0000-1000-8000-00805F9B34FB";
const String sweepstatCharacteristicUUID = "0000FFE1-0000-1000-8000-00805F9B34FB";

class SweepStatBTConnection {
  BluetoothDevice device;
  BluetoothCharacteristic characteristic;
  BluetoothDeviceState bluetoothDeviceState;
  Function disconnectCallback;
  StreamSubscription notifyListener;
  StreamSubscription stateListener;

  SweepStatBTConnection._(BluetoothDevice device, Function disconnectCallback){
    this.device = device;
    this.disconnectCallback = disconnectCallback;
    bluetoothDeviceState = BluetoothDeviceState.connected;
    stateListener = device.state.listen((BluetoothDeviceState state) async{
      if(state == BluetoothDeviceState.disconnected || state == BluetoothDeviceState.disconnecting){
        await endConnection();
      } else {
        bluetoothDeviceState = state;
        // print(this);
      }
    });
  }

  bool isConnected() {
    return bluetoothDeviceState == BluetoothDeviceState.connected;
  }

  Future<void> endConnection() async {
    if (notifyListener != null) notifyListener.cancel();
    if (stateListener != null) stateListener.cancel();
    await device.disconnect();
    disconnectCallback();
    print('connection ended');
  }

  Future<void> writeToSweepStat(String message) async{
    await characteristic.write(message.codeUnits);
  }

  Future<void> addNotifyListener(Function callback) async{
    await characteristic.setNotifyValue(true);
    notifyListener = characteristic.value.listen(callback);
  }

  static Future<SweepStatBTConnection> createSweepBTConnection(BluetoothDevice d, Function c) async{
    SweepStatBTConnection sweepConnection = new SweepStatBTConnection._(d, c);
    // Acquire correct characteristic
    List<BluetoothService> services = await d.discoverServices();

    for (BluetoothService service in services){
      if (service.uuid == Guid(sweepstatServiceUUID)){
        for(BluetoothCharacteristic c in service.characteristics) {
          if (c.uuid == Guid(sweepstatCharacteristicUUID)){
            sweepConnection.characteristic = c;
            break;
          }
        }
      }
    }

    print('services found');
    // Make characteristic exists
    if (sweepConnection.characteristic == null) return null;


    return sweepConnection;
  }
}